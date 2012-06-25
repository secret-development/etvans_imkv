# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ApplicationHelper do
  
  before(:all) do
    @default_title = "Этванс"
  end
  
  describe "#title" do
    it "return the default page" do
      helper.title.should eql("#{@default_title}")
    end
  end
  
end
