# -*- encoding : utf-8 -*-
class HelpController < ApplicationController

  respond_to :html
  before_filter :all_deny
  before_filter :time_work  
  before_filter :check_fired
  # def index
  #   @title = "Справка"
  # end
  
  def search
    @title = "Справка | Поиск"
  end
  
  def customers
    @title = "Справка | Клиенты"
  end
  
  def subjects
    @title = "Справка | Объекты"
  end
  
  def users
    @title = "Справка | Персонал"
  end
  
  def tasks
    @title = "Справка | Задачи"
  end
  
  def transactions
    @title = "Справка | Сделки"
  end
  
  def report
    @title = "Справка | Отчеты"
  end
  
  def danger
    @title = "Справка | Важно"
  end
  
end
