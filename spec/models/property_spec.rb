# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Property do
  before(:each) do
    @city = FactoryGirl.create(:city)
    @typesubject = FactoryGirl.create(:typesubject)
    @district = FactoryGirl.create(:district)
    @customer = FactoryGirl.create(:customer)
    @subject = FactoryGirl.create(:subject, :typesubject => @typesubject, :city => @city, 
        :customer => @customer, :district => @district)
        
    @attr = {
      :condition => "Интернет",
      :value => "Есть",
      :subject_id => @subject.id
    }
  end
  
  describe "validations" do
    it "should subject require" do
      property = Property.new(@attr.merge(:subject_id => nil))
      property.should_not be_valid
    end
    
    # it "should condition require" do
    #   property = Property.new(@attr.merge(:condition => nil))
    #   property.should_not be_valid
    # end
    # 
    # it "should value require" do
    #   property = Property.new(@attr.merge(:value => nil))
    #   property.should_not be_valid
    # end
  end
  
  describe "associations" do
    it "should respond_to subject" do
      property = Property.new(@attr)
      property.should respond_to(:subject)
    end
    
    it "should belongs_to subject" do
      property = Property.reflect_on_association(:subject)
      property.macro.should == :belongs_to
    end
  end
end

# == Schema Information
#
# Table name: properties
#
#  id         :integer(4)      not null, primary key
#  condition  :string(255)
#  value      :string(255)
#  subject_id :integer(4)
#  typefield  :string(255)
#

