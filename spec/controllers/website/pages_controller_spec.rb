# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::PagesController do
  
  describe "GET should be success" do
    
    it "index" do
      get :index
      response.should be_success
    end
    
    it "about" do
      get :about
      response.should be_success
    end

    it ":contacts" do
      get :contacts
      response.should be_success
    end
    
    it "advices" do
      get :advices
      response.should be_success
    end
    
  end
  
end
