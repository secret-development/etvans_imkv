# -*- encoding : utf-8 -*-
class Customer < ActiveRecord::Base
  # associations
  belongs_to :typetransaction
  belongs_to :social_status
  has_many :subjects, :dependent => :destroy
  has_many :transactions, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  accepts_nested_attributes_for :phones, :reject_if => lambda {|a| a[:customerphone].blank? }, :allow_destroy => true
  belongs_to :user
  #validations
  validates :firstname, :presence => true
  #scope
  scope :real, where(:potentials => false)
  scope :potentials, where(:potentials => true)
  #default_scope order("lastname ASC")

  attr_writer :area_code, :phonemobile1, :phonemobile2
  
  # callbacks
  before_save :phonemobile_merge
  before_update :phonemobile_merge
  
  
  
  
  #permalink
#  def to_param
#    permalink    
#  end
  
  def phonemobile_merge
    if (@area_code.blank? || @phonemobile1.blank? || @phonemobile2.blank?)
      if new_record?
        self.phonemobile = ""  
      end
    else
      self.phonemobile = "+7 #{@area_code} #{@phonemobile1} #{@phonemobile2}" 
    end
  end
  
  def area_code
    unless phonemobile.nil?
      phonemobile.split(' ').second
    end
  end
  
  def phonemobile1
    unless phonemobile.nil?
      phonemobile.split(' ').third
    end
  end
  
  def phonemobile2
    unless phonemobile.nil?
      phonemobile.split(' ').fourth
    end
  end
  
  def button_value
    if new_record?
      "Добавить"
    else
      "Редактировать"      
    end    
  end
  
  def legend_value
    if new_record?
      "Добавление клиента"
    else 
      "Редактирование клиента"      
    end    
  end
  
  def self.search(search)
    if search
      where('lastname LIKE ? OR firstname LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end 
  end

  def fullname
    lastname + " " + firstname
  end
  
  def self.check_owner(user, customer)
    if Customer.freeze_have?
      if user.role == true
        true
      else
        if user.id == customer.user_id
          true
        else
          false
        end
      end
    else
      true
    end
  end
  
  def self.freeze_have?
    c = Customeraccess.first
    if c.access == true
      false
    else
      true
    end
  end
  
end
# == Schema Information
#
# Table name: customers
#
#  id                 :integer(4)      not null, primary key
#  firstname          :string(255)
#  lastname           :string(255)
#  phonehome          :string(255)
#  phonemobile        :string(255)
#  email              :string(255)
#  note               :text
#  created_at         :datetime
#  updated_at         :datetime
#  potentials         :boolean(1)      default(FALSE)
#  social_status_id   :integer(4)
#  typetransaction_id :integer(4)
#  lastcall           :datetime
#  user_id            :integer(4)
#

