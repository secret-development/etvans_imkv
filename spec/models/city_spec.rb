# -*- encoding : utf-8 -*-
require 'spec_helper'

describe City do
  before(:each) do
    @attr = {
      :name => "Костанай"
    }
  end
  
  describe "validates" do
    it "should create a new instance given a valid attrbiute" do
      @city = City.create!(@attr)
    end
    
    it "should require a name" do
      @city = City.new(@attr.merge(:name => "")).should_not be_valid
    end
    
    it "should reject name with duplicate" do
      @city = City.create!(@attr)
      city = City.new(@attr.merge(:name => @attr[:name].upcase))
      city.should_not be_valid
    end
    
  end
  
  describe "associations" do
    it "should respond to subjects" do
      @city = City.new(@attr)
      @city.should respond_to(:subjects)
    end
    
    it "should has_many subjects" do
      city = City.reflect_on_association(:subjects)
      city.macro.should == :has_many
    end
    
    it "should dependent destroy" do
      city = City.reflect_on_association(:subjects)
      city.options[:dependent].should == :destroy
    end
    
    it "should respond to districts" do
      @city = City.new(@attr)
      @city.should respond_to(:districts)
    end
    
    it "should has_many districts" do
      @city = City.reflect_on_association(:districts)
      @city.macro.should == :has_many
    end
    
    it "(districts) should dependent destroy" do
      @city = City.reflect_on_association(:districts)
      @city.options[:dependent].should == :destroy
    end
    
    it "should has_many residents" do
      @city = City.reflect_on_association(:residents)
      @city.macro.should == :has_many
    end
    
    it "(residents) should dependent destroy" do
      @city = City.reflect_on_association(:residents)
      @city.options[:dependent].should == :destroy
    end
  end
  
end

# == Schema Information
#
# Table name: cities
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

