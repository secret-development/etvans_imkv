# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# type of transaction:


if ENV['RAILS_ENV'] == "production"
  # type transactions
  exists_typetr = Typetransaction.all
  if exists_typetr.size == 0
    types_of_transactions = ['Купля', 'Продажа', 'Аренда', 'Съем', 'Обмен']
    types_of_transactions.each do |t|
      Typetransaction.create(:name => t)
    end
  end
  
  # users
  users = User.all
  if users.size == 0
    User.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password', :role => true, :lastname => "Иванов", :firstname => "Иван")    
  end
  
  # worktimes
  worktime = Worktime.all
  if worktime.size == 0
    Worktime.create(:start_hour => nil, :start_min => nil, :end_hour => nil, :end_min => nil)
  end
  
  # paginators
  paginators = Paginator.all
  default_page = 25
  resources = ['поиск', 'клиенты', 'объекты', 'задачи', 'сделки']
  if paginators.size == 0
    resources.each do |r|
      Paginator.create(:resource => r, :paginate => default_page)
    end
  end
  
  # customeraccess
  customeraccess = Customeraccess.all
  if customeraccess.size == 0
    Customeraccess.create(:access => true)
  end

elsif ENV['RAILS_ENV'] = "development"
  # type transactions
  exists_typetr = Typetransaction.all
  if exists_typetr.size == 0
    types_of_transactions = ['Купля', 'Продажа', 'Аренда', 'Съем', 'Обмен']
    types_of_transactions.each do |t|
      Typetransaction.create(:name => t)
    end
  end
  
  # users
  users = User.all
  if users.size == 0
    User.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password', :role => true, :lastname => "Иванов", :firstname => "Иван")    
  end
  
  # worktimes
  worktime = Worktime.all
  if worktime.size == 0
    Worktime.create(:start_hour => nil, :start_min => nil, :end_hour => nil, :end_min => nil)
  end
  
  # paginators
  paginators = Paginator.all
  default_page = 25
  resources = ['поиск', 'клиенты', 'объекты', 'задачи', 'сделки']
  if paginators.size == 0
    resources.each do |r|
      Paginator.create(:resource => r, :paginate => default_page)
    end
  end
  
  # customeraccess
  customeraccess = Customeraccess.all
  if customeraccess.size == 0
    Customeraccess.create(:access => true)
  end
  
end
