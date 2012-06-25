# -*- encoding : utf-8 -*-
class ConditionField < ActiveRecord::Base
  
  # callbacks
  before_update :rename_properties
  
  # associations:
  has_many :value_fields, :dependent => :destroy
  belongs_to :typesubject
  
  # validations  
  validates :namefield, :presence => true
  validates :namefield, :uniqueness => { 
            :scope => [:typesubject_id], :case_sensitive => false }
  validates :typefield, :presence => true
  validates :typesubject_id, :presence => true

  # scopes:
  default_scope order("id ASC")
  
  scope :forform,  where("typefield != 'textfield' 
    and  typefield != 'textarea'").reorder("typesubject_id ASC")
  
  def typefields
    {
      "выпадающий список" => "select",
      "радио кнопки" => "radio",
      "текстовое поле" => "textfield",
      "большое текстовое поле" => "textarea" 
    }
  end
  
  def legend_value
    if new_record?
      "Добавить поле"
    else
      "Редактировать поле"
    end
  end

  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"
    end
  end

  def namefield_with_typesubject
    "#{typesubject.name} → #{namefield}"
  end
  
  def rename_properties
    old_name_condition = namefield_was
    new_name_condition = namefield
    new_typefield = typefield
    if namefield_changed? || typefield_changed?
      change_properties(old_name_condition, new_name_condition, new_typefield)
    end
  end
  
  def change_properties(old_name_condition, new_name_condition, new_typefield)
    properties = Property.where(:condition => old_name_condition)
    properties.each do |p|
      p.condition = new_name_condition
      p.typefield = new_typefield
      p.save
    end
  end
  
end
# == Schema Information
#
# Table name: condition_fields
#
#  id             :integer(4)      not null, primary key
#  namefield      :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  typefield      :string(255)
#  typesubject_id :integer(4)
#

