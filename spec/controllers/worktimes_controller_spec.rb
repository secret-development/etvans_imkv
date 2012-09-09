# -*- encoding : utf-8 -*-
require 'spec_helper'

describe WorktimesController do
  render_views
  
  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
  end
  
  it "get index" do
    get :index
    response.should be_success
  end
  
end
