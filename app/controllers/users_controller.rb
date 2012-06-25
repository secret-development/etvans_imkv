# -*- encoding : utf-8 -*-

class UsersController < ApplicationController

  respond_to :html
  before_filter :all_deny 
  # before_filter :time_work
  load_and_authorize_resource

  def index
    @users = User.all    
    @title = "Персонал"
    respond_with(@users)
  end
  
  def new
    @user = User.new
    @title = "Добавление сотрудника"
    respond_with(@user)
  end
  
  def create
    @user = User.create(params[:user])
    if @user.save
      flash[:notice] = "Сотрудник создан"
      respond_with(@user, :location => users_path)
    else
      render 'new'      
    end    
  end
  
  def show
    @user = User.find(params[:id])
    @title = "Информация о сотруднике"
    respond_with(@user)
  end
  
  def edit
    @user = User.find(params[:id])    
    @title = "Редактирование информации"
    respond_with(@user)
  end
  
  def update
    @user = User.find(params[:id])
    if params[:user][:lastname]
      if @user.update_attributes(params[:user])
        flash[:notice] = "Данные изменены"
        respond_with(@user)
      else
        render 'add_info'      
      end      
    else
      if @user.update_attributes(params[:user])
        flash[:notice] = "Данные изменены"
        respond_with(@user)
      else
        render 'edit'      
      end  
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.update_attribute("fired", true)
    @user.reload
    redirect_to users_path
    flash[:notice] = "Сотрудник уволен"
  end
  
  def add_info
    @user = User.find(params[:id])
    @title = "Анкетные данные"
  end
  
end
