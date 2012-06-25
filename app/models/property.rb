# -*- encoding : utf-8 -*-
class Property < ActiveRecord::Base
  # validations
  validates :subject_id, :presence => true
  # validates :condition, :presence => true
  # validates :value, :presence => true
  
  # associations
  belongs_to :subject
  
  attr_accessible :subject_id, :condition, :value, :typefield
  
  
  # def legend_value
  #   new_record? ? "Добавить доп.информацию" : "Редактировать доп.информацию"
  # end
  # 
  # def button_value
  #   new_record? ? "Добавить" : "Редактировать"
  # end
end
# == Schema Information
#
# Table name: properties
#
#  id         :integer(4)      not null, primary key
#  condition  :string(255)
#  value      :string(255)
#  subject_id :integer(4)
#  typefield  :string(255)
#

