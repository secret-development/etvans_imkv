# -*- encoding : utf-8 -*-
class SocialStatus < ActiveRecord::Base
  validates :title, :presence => true, :uniqueness => { :case_sensitive => false }
  has_many :customers, :dependent => :nullify
  default_scope order('title ASC')
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"    
    end  
  end
  
  def legend_value
    if new_record?
      "Добавление статуса"
    else 
      "Редактирование статуса"      
    end    
  end
  
  def self.asctitle
    order("title ASC")    
  end
end

# == Schema Information
#
# Table name: social_statuses
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

