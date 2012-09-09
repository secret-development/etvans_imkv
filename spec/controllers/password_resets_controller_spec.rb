# -*- encoding : utf-8 -*-
require 'spec_helper'

describe PasswordResetsController do
  
  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
  end
  
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

end
