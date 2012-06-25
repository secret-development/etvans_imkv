# -*- encoding : utf-8 -*-
class Typesubject < ActiveRecord::Base
  
  attr_accessor :fields

  # associations:
  has_many :condition_fields, :dependent => :destroy
  has_many :subjects, :dependent => :destroy
  
  # validates
  validates :name, :presence => true, 
            :uniqueness => { :case_sensitive => false }
  # validates :permalink, :presence => true, 
  #               :uniqueness => { :case_sensitive => false }
  validates :floor, :inclusion => { :in => [true, false]}
  validates :room, :inclusion => { :in => [true, false]}
  validates :resident, :inclusion => { :in => [true, false]}
  
  default_scope order("name ASC")
  
  def legend_value
    new_record? ? "Добавить тип недвижимости" : "Редактировать тип недвижимости"
  end
  
  def button_value
    new_record? ? "Добавить" : "Редактировать"
  end
  
  
  def find_conditions
    if condition_fields.size > 0
      @fields = {}
      condition_fields.each do |c|
        @fields[c.namefield] = {}
      end
      return @fields
    end
  end
  
  def find_typefield
    conditions = find_conditions
    condition_fields.each do |c|
      conditions[c.namefield] = {:typefield => c.typefield}
    end
    return conditions
  end
  
  def find_values
    conditions = find_typefield
    condition_fields.each do |c|
      conditions[c.namefield][:value] = []
      if c.value_fields.size > 0
        c.value_fields.each do |v|
          conditions[c.namefield][:value] << v.valuefield
        end        
      else
        conditions[c.namefield].delete(:value)
      end

    end
    @fields = conditions
    return @fields
  end
  
end

# == Schema Information
#
# Table name: typesubjects
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  permalink  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  floor      :boolean(1)
#  room       :boolean(1)
#  resident   :boolean(1)
#

