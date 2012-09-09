# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Document do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    @city = FactoryGirl.create(:city)
    @typesubject = FactoryGirl.create(:typesubject)
    @district = FactoryGirl.create(:district)
    @customer = FactoryGirl.create(:customer)
    @typetransaction = FactoryGirl.create(:typetransaction)
    @subject = FactoryGirl.create(:subject, :typesubject => @typesubject, :city => @city, 
        :customer => @customer, :district => @district)
    @transaction = FactoryGirl.create(:transaction, :typetransaction => @typetransaction,
                    :user => @user, :customer => @customer,
                    :subject => @subject)
    @document = FactoryGirl.create(:document, :transaction => @transaction)
    
    @attr = {
      :transaction_id => @transaction.id,
      :doc => "MyDoc.doc"
    }
    
  end
  
  describe "associations" do
    
    describe "transaction" do
      
      it "should respond to transaction" do
        document = Document.new(@attr)
        document.should respond_to(:transaction)
      end
      
      it "should belongs_to transaction" do
        document = Document.reflect_on_association(:transaction)
        document.macro.should == :belongs_to
      end
      
    end
    
  end
  
end

# == Schema Information
#
# Table name: documents
#
#  id             :integer(4)      not null, primary key
#  transaction_id :integer(4)
#  doc            :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

