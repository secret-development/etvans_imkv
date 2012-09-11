# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Advice do
  
  before(:each) do
    @attr = {
      :title => "Первый совет",
      :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      :author => "Жасулан"
    }
  end
  
  it "should create a new instance with valid attributes" do
    Advice.create!(@attr)
  end
  
  describe "validations" do
    it "should presence title" do
      advice = Advice.new(@attr.merge(:title => nil))
      advice.should_not be_valid
    end
    
    it "should presence body" do
      advice = Advice.new(@attr.merge(:body => nil))
      advice.should_not be_valid
    end
    
    it "should presence author" do
      advice = Advice.new(@attr.merge(:author => nil))
      advice.should_not be_valid
    end
  end
  
end
