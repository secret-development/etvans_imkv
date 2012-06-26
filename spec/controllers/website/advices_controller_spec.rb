# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::AdvicesController do
  render_views
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    
    @advice = Factory(:advice)
  end
  
  it "get :index" do
    get :index
    response.should be_success
  end
  
  it "get :admin_index" do
    get :admin_index
    response.should be_success
  end
  
  it "get :new" do
    get :new
    response.should be_success
  end
  
  it "get :edit" do
    get :edit, :id => @advice.id
    response.should be_success
  end
end
