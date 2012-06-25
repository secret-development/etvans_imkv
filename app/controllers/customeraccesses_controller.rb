# -*- encoding : utf-8 -*-
class CustomeraccessesController < ApplicationController
  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  load_and_authorize_resource
  
  def index
    @title = "Доступ к клиентам"
    @customeraccess = Customeraccess.first
    if @customeraccess.nil?
      @customeraccess = Customeraccess.new
    end
  end
  
  def create
    @customeraccess = Customeraccess.new(params[:customeraccess])
    if @customeraccess.save
      flash[:notice] = "Доступ к клиентам настроен"
      respond_with(@customeraccess, :location => customeraccesses_path)  
    else
      render 'index'
    end
  end
  
  def update
    @customeraccess = Customeraccess.first
    if @customeraccess.update_attributes(params[:customeraccess])
      flash[:notice] = "Доступ к клиентам настроен"
      respond_with(@customeraccess, :location => customeraccesses_path)
    else
      render 'index'
    end
  end
  
  
end
