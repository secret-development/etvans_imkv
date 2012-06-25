# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SettingsController do
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
  end
  
  it "should be success" do
    get :index
    response.should be_success
  end
  
  it "routes to settings" do
    { :get => "/etvans/settings" }.
    should route_to(:controller => "settings", :action => "index")
  end
end
