# -*- encoding : utf-8 -*-
class Website::Advice < ActiveRecord::Base
  
  # validations:
  validates :title, :presence => true
  validates :body, :presence => true
  validates :author, :presence => true
  
  def legend_value
    if new_record?
      "Добавление советы"
    else
      "Редактирование совета"
    end
  end
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"      
    end    
  end
  
end
