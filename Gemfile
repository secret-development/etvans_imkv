source 'http://rubygems.org'

gem 'rails', "~> 3.2.1"

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
gem 'mysql2'

gem "rake", "~> 0.9.2"
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.4'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', ">= 1.0.3"
  gem 'therubyracer'
end

gem 'jquery-rails'
gem "kaminari", "~> 0.13.0"
gem 'validates_timeliness', '~> 3.0.2'
gem 'jquery_datepicker'
gem 'russian', '~> 0.6.0'
gem 'bcrypt-ruby', :require => 'bcrypt'

# for attachment:
gem "carrierwave", "~> 0.5.8"
gem 'flash_cookie_session'

# Authorization
gem "cancan", "~> 1.6.7"

gem 'simple_form'
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# for search:
gem "squeel"
gem "meta_search"

# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'
gem 'mini_magick'
# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# for backup
gem 'backup'
gem 'dropbox-sdk', '~> 1.1.0'

group :development do
  gem "awesome_print", "~> 1.0.2"
  gem "magic_encoding", "~> 0.0.2"  
  # annotate model:
  gem 'annotate', '~> 2.4.1.beta'
  gem "rspec", "~> 2.8.0"
  gem "rspec-rails", "~> 2.8.1"
end

group :test do
  gem 'spork', '~> 1.0rc'
  gem "rspec", "~> 2.8.0"
  gem "rspec-rails", "~> 2.8.1"
  gem "capybara", "~> 1.1.2"
  gem "watchr"
  gem 'factory_girl_rails'
  gem "database_cleaner", "~> 0.7.1"
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'simplecov', :require => false
  # annotate model:
  gem 'annotate', '~> 2.4.1.beta'
  gem 'mini_magick'
end