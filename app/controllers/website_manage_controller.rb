# -*- encoding : utf-8 -*-
class WebsiteManageController < ApplicationController
  
  before_filter :all_deny
  before_filter :settings_deny
  respond_to :html
  
  def index
    @title = "Управление сайтом"  
  end
  
end
