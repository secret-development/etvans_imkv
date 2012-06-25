# -*- encoding : utf-8 -*-
class Report < ActiveRecord::Base
  # finance report
  def self.total_dollar(date)
    Transaction.where("date(created_at) = ? AND price_currency = ?", date, "доллар").sum(:price)    
  end
  
  def self.total_ru(date)
    Transaction.where("date(created_at) = ? AND price_currency = ?", date, "рубль").sum(:price)    
  end
  
  def self.total_euro(date)
    Transaction.where("date(created_at) = ? AND price_currency = ?", date, "евро").sum(:price)    
  end
  
  def self.total_tg(date)
    Transaction.where("date(created_at) = ? AND price_currency = ?", date, "тенге").sum(:price)    
  end
  
  # activ users report
  def self.find_user(user)
    @u = User.find(user) 
  end
  
  def self.return_name
    @u.fullname    
  end
  
  def self.activ_user(date)
    cust = @u.customers.where("date(created_at) = ?", date).count(:id)
    sub = @u.subjects.where("date(created_at) = ?", date).count(:id)
    tran = @u.transactions.where("date(created_at) = ?", date).count(:id)
    summa = (cust + sub + tran)/3.0
    return summa.to_f.round(3)
  end
  
  #GENERAL 
  #all customers count
  def self.all_customers_count
    Customer.count(:id)    
  end
  # all subjects count
  def self.all_subjects
    Subject.count(:id)    
  end
  # real customers count
  def self.real_customers_count
    Customer.where("potentials = false").count(:id)    
  end
  # potentials customers count
  def self.potential_customers_count
    Customer.where("potentials = true").count(:id)    
  end
  
  def self.customers_add(date)
    Customer.where("date(created_at) = ?", date).count(:id)    
  end
  
  def self.subjects_add(date)
    Subject.where("date(created_at) = ?", date).count(:id)    
  end
  
#  def self.activ_user_cust(date)
#    @u.customers.where("date(created_at) = ?", date).count(:id)        
#  end
#  
#  def self.activ_user_sub(date)
#    @u.subjects.where("date(created_at) = ?", date).count(:id)    
#  end
#  
#  def self.activ_user_tran(date)
#    @u.transactions.where("date(created_at) = ?", date).count(:id)    
#  end
     
end
