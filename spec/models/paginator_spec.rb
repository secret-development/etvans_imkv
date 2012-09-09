# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Paginator do
  before(:each) do
    @paginator = FactoryGirl.create(:paginator)
    
    @attr = {
      :resource => "клиенты",
      :paginate => 20
    }
  end

  describe "validations" do
    it "should require the paginate" do
      paginator = Paginator.new(@attr.merge(:paginate => nil))
      paginator.should_not be_valid
    end
    
    it "should require only numericality" do
      paginator = Paginator.new(@attr.merge(:paginate => "a"))
      paginator.should_not be_valid
    end
    
    it "should require paginate >= 1" do
      paginator = Paginator.new(@attr.merge(:paginate => 0))
      paginator.should_not be_valid
    end
  end

end
