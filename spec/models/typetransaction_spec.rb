# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Typetransaction do
  before(:each) do
    @typetransaction = Factory(:typetransaction)
    
    # valid data
    @attr = {
      :name => "Обмен"
    }
  end
  
  describe "associations" do
    describe "has_many :customers" do
      it "should respond_to customers" do
        @typetransaction = Typetransaction.new(@attr)
        @typetransaction.should respond_to(:customers)
      end
      
      it "should has_many :customers" do
        t = Typetransaction.reflect_on_association(:customers)
        t.macro.should == :has_many
      end
      
    end
    
    describe "has_many :subjects" do
      it "should respond to subjects" do
        t = Typetransaction.new(@attr)
        t.should respond_to(:subjects)
      end
      
      it "should has_many :subjects" do
        t = Typetransaction.reflect_on_association(:subjects)
        t.macro.should == :has_many
      end
    end
    
    describe "has_many :transactions" do
      it "should respond to transactions" do
        t = Typetransaction.new(@attr)
        t.should respond_to(:transactions)
      end
      
      it "should has_many :transactions" do
        t = Typetransaction.reflect_on_association(:transactions)
        t.macro.should == :has_many
      end
    end
  end
end

# == Schema Information
#
# Table name: typetransactions
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

