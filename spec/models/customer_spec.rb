# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Customer do

  before(:each) do
    @attr = {
      :firstname => "Ivan",
      :lastname => "Ivanov",
      :phonehome => "839321",
      :phonemobile => "87771234567",
     # :real => true,
    }
  end
  
  it "should create a new instance with valid attributes" do
    Customer.create!(@attr)    
  end
  
  it "must be zero by default and save attributes" do 
    @c = Customer.create(@attr)
    @c.potentials?().should be_false
    @c.save.should eq(true)    
  end
  
  
  it "should respond to social_status" do
    s = Customer.new
    s.should respond_to(:social_status)    
  end
  
  it "should have one status" do
    t = Customer.reflect_on_association(:social_status)
    t.macro.should ==:belongs_to
  end
  
  
  
  describe "associations" do
    it "should respond to typetransaction" do
      c = Customer.new(@attr)
      c.should respond_to(:typetransaction)
    end
    
    it "shouild belongs_to to typetransaction" do
      c = Customer.reflect_on_association(:typetransaction)
      c.macro.should == :belongs_to
    end
    
    it "should respond to subjects" do
      c = Customer.new(@attr)
      c.should respond_to(:subjects)
    end
    
    it "should has_many :subjects" do
      c = Customer.reflect_on_association(:subjects)
      c.macro.should == :has_many
    end
    
    it "should respond to transactions" do
      c = Customer.new(@attr)
      c.should respond_to(:transactions)
    end
    
    it "should has_many :transactions" do
      c = Customer.reflect_on_association(:transactions)
      c.macro.should == :has_many
    end
    
    it "should dependent(transactions) destroy" do
      c = Customer.reflect_on_association(:transactions)
      c.options[:dependent].should == :destroy
    end
    
    it "should dependent destroy(subjects)" do
      c = Customer.reflect_on_association(:subjects)
      c.options[:dependent].should == :destroy
    end
    
    it "should respond to phones" do
      c = Customer.new(@attr)
      c.should respond_to(:phones)
    end
    
    it "should has_many phones" do
      c = Customer.reflect_on_association(:phones)
      c.macro.should == :has_many
    end
    
    it "should dependent(:phones) destroy" do
      c = Customer.reflect_on_association(:phones)
      c.options[:dependent].should == :destroy
    end
  end
  
  describe "validates" do
    it "should presence firstname" do
      customer = Customer.new(@attr.merge(:firstname => nil))
      customer.should_not be_valid
    end
    
    it "should valid without lastname" do
      customer = Customer.new(@attr.merge(:lastname => nil))
      customer.should be_valid
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

