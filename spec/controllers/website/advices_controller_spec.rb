# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::AdvicesController do
  render_views
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
  end
end
