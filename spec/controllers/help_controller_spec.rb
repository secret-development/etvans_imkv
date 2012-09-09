# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HelpController do
  render_views
  
  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
  end
  
  # it "get index" do
  #   get :index
  #   response.should be_success
  # end
  
  it "get search" do
    get :search
    response.should be_success
  end
  
  it "get customers" do
    get :customers
    response.should be_success
  end
  
  it "get subjects" do
    get :subjects
    response.should be_success
  end
  
  it "get users" do
    get :users
    response.should be_success
  end
  
  it "tasks" do
    get :tasks
    response.should be_success
  end
  
  it "transactions" do
    get :transactions
    response.should be_success
  end
  
  it "reports" do
    get :reports
    response.should be_success
  end
  
  it "danger" do
    get :danger
    response.should be_success    
  end
  
end
