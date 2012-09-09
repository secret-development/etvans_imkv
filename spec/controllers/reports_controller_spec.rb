# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ReportsController do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
  end
  
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should redirect_to(finance_reports_path)
    end
  end

end
