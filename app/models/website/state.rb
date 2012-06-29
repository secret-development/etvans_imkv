# -*- encoding : utf-8 -*-
class Website::State < ActiveRecord::Base
  # validations:
  validates :title, :presence => true
  validates :description, :presence => true
  validates :address, :presence => true

  # carrierwave
  mount_uploader :jk, JkUploader
  
  def legend_value
    if new_record?
      "Добавление ЖК"
    else
      "Редактирование ЖК"
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