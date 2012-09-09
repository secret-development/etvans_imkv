# -*- encoding : utf-8 -*-
require 'spec_helper'

describe PotentialsController do

  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
