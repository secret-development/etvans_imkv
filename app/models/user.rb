# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :password, :password_confirmation, 
                  :password_reset_token, :password_reset_sent_at, 
                  :role, :lastname, :firstname, :phonehome, :phonemobile,
                  :area_code, :phonemobile1, :phonemobile2, :fired, :last_sign_in_at, :last_log_out_at
  #encript password before save
  before_save :encrypt_password
  
  
  # phone:
  attr_writer :area_code, :phonemobile1, :phonemobile2
  before_save :phonemobile_merge
  before_update :phonemobile_merge
  
  # remember me
  before_create { generate_token(:auth_token) }
  
  #association
  has_many :transactions, :dependent => :nullify
  has_many :customers, :dependent => :nullify
  has_many :tasks, :dependent => :nullify
  has_many :subjects, :dependent => :nullify
  # validations
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :password, :confirmation => true, 
    :length => {:within => 6..20}, :on => :create
  validates :password_confirmation, :presence => true, :on => :create
  
  validates :email, :uniqueness => { :case_sensitive => false}
  validates :email, :presence => true, :format => {:with => email_regex}
  validates :lastname, :firstname, :presence => true
  # validates :phonemobile, :presence => true
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end    
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) && user.fired == false
      user
    else
      nil      
    end        
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64      
    end while User.exists?(column => self[column])    
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver    
  end
  
  def legend_value
    if new_record?
      "Добавление нового сотрудника"
    else
      "Изменение анкетных данных"      
    end
  end
  
  def label_value
    if new_record?
      "Введите пароль"
    else
      "Введите новый пароль"      
    end    
  end
  
  def button_value
    if new_record?
      "Создать"
    else
      "Изменить"      
    end    
  end
  
  def legend_password
    "Изменение пароля"    
  end
  
  # phone:
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
  
  def fullname
    lastname + " " + firstname
  end
  
  #last_sign_in_at
  def last_sign
    self.last_sign_in_at = Time.current
    save!    
  end
  
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)
#  password_hash          :string(255)
#  password_salt          :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  role                   :boolean(1)
#  firstname              :string(255)
#  lastname               :string(255)
#  phonemobile            :string(255)
#  phonehome              :string(255)
#  fired                  :boolean(1)      default(FALSE)
#  last_sign_in_at        :datetime
#

