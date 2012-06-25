# -*- encoding : utf-8 -*-
class WorktimesController < ApplicationController
  
  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  load_and_authorize_resource
  
  def index
    @title = "Рабочее время"
    @worktime = Worktime.first
    if @worktime.nil?
      @worktime = Worktime.new
    end
  end
  
  def create
    @worktime = Worktime.new(params[:worktime])
    if @worktime.save
      flash[:notice] = "Рабочее время настроено"
      respond_with(@worktime, :location => worktimes_path)  
    else
      render 'index'
    end
  end
  
  def update
    @worktime = Worktime.first
    if @worktime.update_attributes(params[:worktime])
      flash[:notice] = "Рабочее время настроено"
      respond_with(@worktime, :location => worktimes_path)
    else
      render 'index'
    end
  end
  
end
