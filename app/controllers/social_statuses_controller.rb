# -*- encoding : utf-8 -*-

class SocialStatusesController < ApplicationController

  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  load_and_authorize_resource
  
  def index
    @socialstatuses = SocialStatus.all
    @title = "Социальные статусы"
    respond_with @socialstatuses    
  end
  
  def new
    @socialstatus = SocialStatus.new
    @title = "Добавление социального статуса"
    respond_with @socialstatus    
  end

  
  def edit
    @socialstatus = SocialStatus.find(params[:id])
    @title = "Редактирование социального статуса"
    respond_with @socialstatus    
  end
  
  def create
    @socialstatus = SocialStatus.new(params[:social_status])
    if @socialstatus.save
      flash[:notice] = "Социальный статус создан!"
      respond_with(@socialstatus, :location => social_statuses_path)
    else
      render 'new'      
    end    
  end
  
  def update
    @socialstatus = SocialStatus.find(params[:id])
    if @socialstatus.update_attributes(params[:social_status])
      flash[:notice] = "Социальный статус обновлен!"
      respond_with(@socialstatus, :location => social_statuses_path)
    else
      render 'edit'      
    end    
  end
  
  def destroy
    @socialstatus = SocialStatus.find(params[:id])
    @socialstatus.destroy
    redirect_to social_statuses_path
    flash[:notice] = "Социальный статус удален!"    
  end  
end
