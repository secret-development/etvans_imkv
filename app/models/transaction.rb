# -*- encoding : utf-8 -*-

class Transaction < ActiveRecord::Base
  
  #associations
  belongs_to :user
  belongs_to :customer
  belongs_to :subject
  belongs_to :typetransaction
  has_many :documents, :dependent => :destroy
  
  #validations
  validates :user_id, :customer_id, :typetransaction_id,
            :presence => true
  validates :name,
            :presence => true,
            :length => { :maximum => 140 }
  validates :description,
            :presence => true,
            :length => { :maximum => 800 }
  validates :price,
            :presence => true,
            :numericality => true          
  validates_inclusion_of :payment, :in => [true, false]
  validates :price_currency, :presence => true
  
  # callbacks
  after_update :check_active_subject
  before_save :check_active_subject
  before_validation :format_price
  after_validation :set_user_lastname

  # verify customer real
  after_save :verify_cust_real
  after_update :verify_cust_real
  after_destroy :verify_cust_real
  
  # price currency
  def price_cur
    {
      "доллар" => "доллар",
      "тенге" => "тенге",
      "евро" => "евро",
      "рубль" => "рубль"
    }
  end
  
  def verify_cust_real
    if customer_id
      cust = Customer.find(customer_id)
      if cust.subjects.empty?
        if cust.transactions.count > 0
          cust.update_attributes(:potentials => false)
        else
          cust.update_attributes(:potentials => true)
        end
      end  
    end
  end
  
  
  #methods
  def payment_value
    payment == true ? "Сделка оплачена" : "Сделка не оплачена"
  end
  
  def payment_short
    payment == true ? "Да " : "Нет"
  end
  
  def legend
    new_record? ? "Добавление" : "Редактирование"
  end
  
  def button_value
    new_record? ? "Добавить" : "Обновить"
  end
  
  def self.search(search)
    if search
      where('name LIKE ? OR user_lastname LIKE ? OR customers.lastname LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%") 
    else
      scoped
    end
  end
  
  def check_active_subject
    if subject_id != nil
      if payment == true
        sub = Subject.find(subject_id)
        if sub.active == true
          sub.update_attribute(:active, false)
        end
      else
        sub = Subject.find(subject_id)
        if sub.active == false
          sub.update_attribute(:active, true)
        end
      end
    end
  end
  
#  def self.total_on(date)
#    where("date(created_at) = ?", date).sum(:price)         
#  end
  

  def format_price
    self.price = price_before_type_cast.to_s.gsub(/\s/, '')
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
# Table name: transactions
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  description        :text
#  customer_id        :integer(4)
#  user_id            :integer(4)
#  typetransaction_id :integer(4)
#  subject_id         :integer(4)
#  price              :integer(4)
#  payment            :boolean(1)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  admin              :boolean(1)
#  price_currency     :string(255)
#  user_lastname      :string(255)
#

