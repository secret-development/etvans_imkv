# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Phone do
  before(:each) do
    # factory:
    
    @user = Factory(:user)
    @customer = Factory(:customer, :user => @user)
    @phone = Factory(:phone, :customer => @customer)
    # attributes:
    @attr = {
      :customerphone => "+ 7 755 434 334 43",
      :customer_id => @customer.id
    }
  end
  
  describe "validations" do
    it "should create a new instance with valid attributes" do
      Phone.create!(@attr)
    end
  end
  
  describe "associations" do
    it "should respond to customer" do
      phone = Phone.new(@attr)
      phone.should respond_to(:customer)
    end
    
    it "should belongs_to to city" do
      phone = Subject.reflect_on_association(:customer)
      phone.macro.should == :belongs_to
    end
  end  
  
end
