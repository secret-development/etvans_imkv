# -*- encoding : utf-8 -*-
#encoding: UTF-8

class Task < ActiveRecord::Base
  
  attr_accessible :title, :description, :user_id, :deadline, :done, :admin,
                  :user_lastname
  belongs_to :user
  validates :user_id,
            :presence => true
  validates :title, 
            :presence => true,
            :length => { :maximum => 140 }
  validates :description,
            :presence => true,
            :length => { :maximum => 800 }
  validates :deadline, 
            :presence => true,
            :timeliness => { :on_or_after => :date_for_validation, :type => :datetime }
  validates_inclusion_of :done, :in => [true, false]
  
  after_validation :set_user_lastname
  
  def status
    done == true ? "Да " : "Нет"
  end
  
  def button_value
    new_record? ? "Добавить" : "Обновить"
  end
  
  def legend
    new_record? ? "Добавление" : "Редактирование"
  end
  
  def date_for_validation
    new_record? ? Time.current : created_at
  end
    
  def self.search(search)
    if search
      where('title LIKE ? OR user_lastname LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
  
  protected
  
  def set_user_lastname
    if self.user != nil
      self.update_attribute(:user_lastname, self.user.lastname)
    end
  end
  
end

# == Schema Information
#
# Table name: tasks
#
#  id            :integer(4)      not null, primary key
#  title         :string(255)
#  description   :text
#  user_id       :integer(4)
#  deadline      :datetime
#  done          :boolean(1)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  admin         :boolean(1)
#  user_lastname :string(255)
#
