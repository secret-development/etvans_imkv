# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SocialStatus do
  before(:each) do
    @attr = {
      :title => "Семейные"
    }
  end
  it "should be create" do
    SocialStatus.create!(@attr)    
  end
  
  it "should respond to customer" do
    s = SocialStatus.new
    s.should respond_to(:customers)    
  end
  
  it "should have many customers" do
    s = SocialStatus.reflect_on_association(:customers)
    s.macro.should ==:has_many    
  end
  
  it "validation uniqueness" do
    SocialStatus.create!(@attr)
    old_title = SocialStatus.new(@attr)
    old_title.should_not be_valid    
  end
  
  it "validations uniqueness case sensetive" do
    SocialStatus.create!(@attr)
    old_title = SocialStatus.new(@attr.merge(:title => @attr[:title].upcase))
    old_title.should_not be_valid    
  end
end

# == Schema Information
#
# Table name: social_statuses
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

