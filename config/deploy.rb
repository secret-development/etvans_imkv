# -*- encoding : utf-8 -*-

# set up
set :application, "imkv"
set :scm, :git
set :repository,  "git://github.com/secret-development/real-box.git"

set :user, "hosting_lagox"
set :use_sudo, false
set :deploy_to, "/home/#{user}/projects/#{application}"
set :keep_releases, 1

role :web, "lithium.locum.ru"
role :app, "lithium.locum.ru"
role :db,  "lithium.locum.ru", :primary => true
set :deploy_via, :remote_cache
set :unicorn_conf, "/etc/unicorn/#{application}.lagox.rb"
set :unicorn_pid, "/var/run/unicorn/#{application}.lagox.pid"
set :unicorn_start_cmd, "(cd #{deploy_to}/current; rvm use 1.9.3 do bundle exec unicorn_rails -Dc #{unicorn_conf})"


# database.yml
after "deploy:update_code", :copy_database_config
task :copy_database_config, roles => :app do
 db_config = "#{shared_path}/database.yml"
 run "cp #{db_config} #{release_path}/config/database.yml"
end

# for carrierwave
after "deploy:update_code", :symlink_shared
task :symlink_shared, roles => :app do
  run "ln -nfs #{shared_path}/system #{release_path}/public/uploads"
end

after "deploy", "deploy:bundle_gems"
after "deploy", "deploy:cleanup"
after "deploy:bundle_gems", "deploy:migrate"
after "deploy:migrate", "deploy:seed"
after "deploy:seed", "deploy:ascompile"
after "deploy:ascompile", "deploy:restart"

# - for unicorn - #
namespace :deploy do
  # assets
  desc "Compile assets"
  task :ascompile, :roles => :app do
    run "cd #{current_path} && rvm use 1.9.3 do bundle exec rake assets:precompile RAILS_ENV=production"    
  end
  
  # migrate
  desc "Migrations db"
  task :migrate, :roles => :app do
    run "cd #{current_path} && rvm use 1.9.3 do bundle exec rake RAILS_ENV=production db:migrate"
  end
  
  # seed
  desc "Seeding data"
  task :seed do
    puts "\n\n=== Populating the Production Database! ===\n\n"
    run "cd #{current_path} && rvm use 1.9.3 do bundle exec rake RAILS_ENV=production db:seed"
    puts "\n\n------- end seed -------\n\n"
  end
  
  # bundle install
  desc "Bundle install"
  task :bundle_gems, :roles => :app do
    puts "\n\n=== Install gems ===\n\n"
    run "cd #{current_path} && rvm use 1.9.3 do bundle install --without development --without test --path ~/.gem"
    puts "\n\n=== end install gems ===\n\n"
  end
  
  desc "Start application"
  task :start, :roles => :app do
    run unicorn_start_cmd
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -QUIT `cat #{unicorn_pid}`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "[ -f #{unicorn_pid} ] && kill -USR2 `cat #{unicorn_pid}` || #{unicorn_start_cmd}"
  end
  
  desc "Empty log files"
  task :logclean, :roles => :app do
    run "cd #{shared_path}/log && echo -n > unicorn.stderr.log && echo -n > production.log"
  end
end
