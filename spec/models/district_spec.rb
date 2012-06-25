# -*- encoding : utf-8 -*-
require 'spec_helper'

describe District do
  before(:each) do
    @city = Factory(:city)
    @district = Factory(:district, :city => @city)
    @attr = {
      :city_id => 1,
      :title => "КЖБИ"
    }
  end
  
  it "should create with valid data" do
    district = District.create!(@attr)
  end
  
  describe "associations with city" do
    it "should respond_to city" do
      district = District.new(@attr)
      district.should respond_to(:city)
    end
    
    it "should belongs_to :city" do
      district = District.reflect_on_association(:city)
      district.macro.should == :belongs_to
    end
  end
  
  describe "association with subjects" do
    it "should respond to subjects" do
      district = District.new(@attr)
      district.should respond_to(:subjects)
    end
    
    it "should has_many :subjects" do
      district = District.reflect_on_association(:subjects)
      district.macro.should == :has_many
    end
    
    it "should dependent(:nullify)" do
      district = District.reflect_on_association(:subjects)
      district.options[:dependent].should == :nullify
    end
  end
  
  describe "validates" do
    it "should reject duplicate" do
      District.create!(@attr)
      @district = District.new(@attr)
      @district.should_not be_valid
    end
    
    it "should reject duplicate(case sensitive)" do
      District.create!(@attr)
      @district = District.new(@attr.merge(:title => @attr[:title].downcase))
      @district.should_not be_valid
    end
    
    it "should not reject duplicate with diff city_id" do
      District.create!(@attr)
      @district = District.new(@attr.merge(:city_id => 2))
      @district.should be_valid
    end
    
    it "should reject with blan title" do
      @attr[:title] = ""
      @district = District.new(@attr)
      @district.should_not be_valid
    end
  end
end

# == Schema Information
#
# Table name: districts
#
#  id         :integer(4)      not null, primary key
#  city_id    :integer(4)
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

