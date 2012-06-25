# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Resident do
  before(:each) do
    @city = Factory(:city)
    @resident = Factory(:resident, :city => @city)
    @attr = {
      :city_id => 1,
      :title => "Сайран"
    }
  end
  
  it "should create with valid data" do
    resident = Resident.create!(@attr)
  end
  
  describe "associations with city" do
    it "should respond_to city" do
      resident = Resident.new(@attr)
      resident.should respond_to(:city)
    end
    
    it "should belongs_to :city" do
      resident = Resident.reflect_on_association(:city)
      resident.macro.should == :belongs_to
    end
  end
  
  describe "association with subjects" do
    it "should respond to subjects" do
      resident = Resident.new(@attr)
      resident.should respond_to(:subjects)
    end
    
    it "should has_many :subjects" do
      resident = Resident.reflect_on_association(:subjects)
      resident.macro.should == :has_many
    end
    
    it "should dependent(:nullify)" do
      resident = Resident.reflect_on_association(:subjects)
      resident.options[:dependent].should == :nullify
    end
  end
  
  describe "validates" do
    it "should reject duplicate" do
      Resident.create!(@attr)
      @resident = Resident.new(@attr)
      @resident.should_not be_valid
    end
    
    it "should reject duplicate(case sensitive)" do
      Resident.create!(@attr)
      @resident = Resident.new(@attr.merge(:title => @attr[:title].downcase))
      @resident.should_not be_valid
    end
    
    it "should not reject duplicate with diff city_id" do
      Resident.create!(@attr)
      @resident = Resident.new(@attr.merge(:city_id => 2))
      @resident.should be_valid
    end
    
    it "should reject with blan title" do
      @attr[:title] = ""
      @resident = Resident.new(@attr)
      @resident.should_not be_valid
    end
  end

end

# == Schema Information
#
# Table name: residents
#
#  id      :integer(4)      not null, primary key
#  title   :string(255)
#  city_id :integer(4)
#

