# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::PagesController do
  
  describe "GET should be success" do
    
    it "index" do
      get :index
      response.should be_success
    end
    
    it "should be success" do
      get :about
      response.should be_success
    end

    it "does something" do
      get :contacts
      response.should be_success
    end
    
    
  end
  
end
