# -*- encoding : utf-8 -*-

class SessionsController < ApplicationController 
  
  before_filter :load_worktime, :only => [:new, :create]
  
  respond_to :html
  layout 'devise'
  
  def new
    @title = "Вход"
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])  
    #user = User.find_by_email(params[:email])
    if user #&& user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      if user.role == false
        current_time  = Time.current
        if(@w.start_hour.nil? && @w.start_min.nil? && @w.end_hour.nil? && @w.end_min.nil?)
          flash[:notice] = "Добро пожаловать"
          user.last_sign
          redirect_to search_path
        elsif(current_time.hour >= @w.start_hour && current_time.min >= @w.start_min && current_time.hour <= @w.end_hour)
          if(current_time.hour == @w.end_hour && current_time.min > @w.end_min)
            cookies.delete(:auth_token)
            redirect_to sign_in_path
            flash[:alert] = "Рабочий день закончился"
          else
            flash[:notice] = "Добро пожаловать"
            user.last_sign
            redirect_to search_path
          end
        else
          cookies.delete(:auth_token)
          redirect_to sign_in_path
          flash[:alert] = "Рабочий день закончился"
        end
      else
        #session[:user_id] = user.id
        flash[:notice] = "Добро пожаловать"
        user.last_sign
        redirect_to search_path
      end
    else
      flash[:alert] = "Неправильный почтовый адрес или пароль!"
      render 'new'
    end    
  end
  
  def destroy
    cookies.delete(:auth_token)
    redirect_to sign_in_path
    flash[:notice] = "Вы вышли из системы"    
  end
  
  private 
  
    def load_worktime
      @w = Worktime.first
    end
end
