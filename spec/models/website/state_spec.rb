# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::State do
  before(:each) do
    @attr = {
      :title => "Радуга",
      :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      :address => "Петрова"
    }
  end
  
  it "should create a new object" do
    Website::State.create!(@attr)
  end
  
  describe "validations" do
    it "should presence title" do
      state = Website::State.new(@attr.merge(:title => nil))
      state.should_not be_valid
    end
    
    it "should presence description" do
      state = Website::State.new(@attr.merge(:description => nil))
      state.should_not be_valid
    end
    
    it "should presence address" do
      state = Website::State.new(@attr.merge(:address => nil))
      state.should_not be_valid
    end
  end
end
