# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ResultsController do
  render_views
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
  end
  
  it "get 'index" do
    get :index
    response.should be_success
  end

end
