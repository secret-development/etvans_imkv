# -*- encoding : utf-8 -*-

class SettingsController < ApplicationController
  
  before_filter :all_deny
  before_filter :settings_deny
  
  def index
    @title = "Настройки"
  end
end
