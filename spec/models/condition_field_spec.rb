# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ConditionField do

  before(:each) do
    
    @typefields = { 
      "выпадающий список" => "select",
      "радио кнопки" => "radio",
      "текстовое поле" => "textfield",
      "большое текстовое поле" => "textarea"
      }
      
    @attr = {
      :namefield => "Состояние",
      :typefield => @typefields["выпадающий список"],
      :typesubject_id => 2
    }
    
    @typesubject = FactoryGirl.create(:typesubject)
    @conditionfield = FactoryGirl.create(:condition_field, :typesubject => @typesubject)
    
  end
  
  describe "validates" do
      
    it "should create a new instance given a valid attribute" do
      @conditionfield = ConditionField.create!(@attr)
    end
    
    it "should require namefield" do
      @conditionfield = ConditionField.new(@attr.merge(:namefield => ""))
      @conditionfield.should_not be_valid
    end
    
    it "should require typefield" do
      @conditionfield = ConditionField.new(@attr.merge(:typefield => ""))
      @conditionfield.should_not be_valid
    end
    
    it "should require typsubject_id(assocation)" do
      @conditionfield = ConditionField.new(@attr.merge(:typesubject_id => nil))
      @conditionfield.should_not be_valid
    end
    
    it "typefield should include value of TYPEFIELDS" do
      (@typefields.to_s).should include(@conditionfield.typefield)
    end
    
    it "should reject duplicate namefield" do
      ConditionField.create!(@attr)
      condition_field_with_dup = ConditionField.new(@attr)
      condition_field_with_dup.should_not be_valid
    end
    
    it "should not reject duplicate namefield with diff typesubject" do
      ConditionField.create!(@attr)
      condition = ConditionField.new(@attr.merge(:typesubject_id => 4))
      condition.should be_valid
    end
    
    it "should reject duplicate namefield(case sensitive)" do
      ConditionField.create!(@attr)
      condition = 
      ConditionField.new(@attr.merge(:namefield => @attr[:namefield].upcase))
      condition.should_not be_valid
    end
    
  end
  
  describe "association" do
    it "should respond to value_fields" do
      c = ConditionField.new(@attr)
      c.should respond_to(:value_fields)
    end
    
    it "should has_many value_fields" do
      c = ConditionField.reflect_on_association(:value_fields)
      c.macro.should == :has_many
    end
    
    it "should dependent destroy" do
      c = ConditionField.reflect_on_association(:value_fields)
      c.options[:dependent].should == :destroy
    end
    
    it "should respond to typesubject" do
      @conditionfield.should respond_to(:typesubject)
    end
    
    it "should belongs_to typesubject" do
      c = ConditionField.reflect_on_association(:typesubject)
      c.macro.should == :belongs_to
    end    
  end
  
  describe "scopes" do
    
    it "formfor scopes should return order(typesubject_id ASC)" do
      @conditionfields = ConditionField.forform
      @conditionfields.to_sql.should =~ /typesubject_id ASC/i
    end
  end
  
end

# == Schema Information
#
# Table name: condition_fields
#
#  id             :integer(4)      not null, primary key
#  namefield      :string(255)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  typefield      :string(255)
#  typesubject_id :integer(4)
#

