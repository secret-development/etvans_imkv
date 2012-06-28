# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::PagesController do
  
  render_views
  
  describe "GET should be success" do
    
    before(:each) do
      @advice = Factory(:tip)
    end
    
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
  end
  
  describe "advices" do
    it "advices" do
      get :advices
      response.should be_success
    end
    
    it "show advice" do
      get :show_advice, :id => @advice.id
      response.should be_success
    end
  end
  
end
