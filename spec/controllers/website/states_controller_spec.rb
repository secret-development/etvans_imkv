# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::StatesController do
  render_views
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    
    @state = Factory(:state)
  end
  
  describe "success requests" do
    it "get :index" do
      get :index
      response.should be_success
    end
    
    it "get :show" do
      get :show, :id => @state.id
      response.should be_success
    end
    
    it "get :new" do
      get :new
      response.should be_success
    end
    
    it "get :edit" do
      get :edit, :id => @state.id
      response.should be_success
    end
  end
end
