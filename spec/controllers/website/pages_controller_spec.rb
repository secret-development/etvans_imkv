# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::PagesController do
  
  render_views
  
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
  end
  
  describe "advices" do
    it "advices" do
      get :advices
      response.should be_success
    end
  end
  
  describe "states" do
    it "states" do
      get :states
      response.should be_success
    end
  end
  
  describe "all subjects" do
    it "all_subjects" do
      get :all_subjects
      response.should be_success
    end
  end
  
end