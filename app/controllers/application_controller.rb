# -*- encoding : utf-8 -*-

class ApplicationController < ActionController::Base
  protect_from_forgery  
  
  helper_method :redirect_to
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to search_path, :alert => exception.message    
  end
  
  def current_ability
    @current_ability ||= Ability.new(current_user)    
  end
  
  def tasks_size
    current_user.tasks.where(:done => false).size
  end
  
  helper_method :tasks_size
    
  private
  
    def current_user
      @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]     
    end
    
    helper_method :current_user
    
    def all_deny
      unless current_user#User.find_by_id(session[:user_id])
        redirect_to sign_in_path
      end
    end
    
    def settings_deny
      unless current_user.role?
        flash[:alert] = "Запрещено!"
        redirect_to search_path
      end            
    end
  
    def time_work
      if current_user.role == false
        current_time = Time.current
        @w = Worktime.first
        if(@w.start_hour.nil? && @w.start_min.nil? && @w.end_hour.nil? && @w.end_min.nil?)
          true
        elsif(current_time.hour >= @w.start_hour && current_time.min >= @w.start_min && current_time.hour <= @w.end_hour)
          if(current_time.hour == @w.end_hour && current_time.min > @w.end_min)
            cookies.delete(:auth_token)
            redirect_to sign_in_path
            flash[:notice] = "Рабочий день закончился"
          else
            true
          end
        else
          cookies.delete(:auth_token)
          redirect_to sign_in_path
          flash[:notice] = "Рабочий день закончился"
        end
      end
    end
    
    def check_fired
      if current_user.fired == true
        cookies.delete(:auth_token)
        redirect_to sign_in_path
        flash[:notice] = "Вас уволили"
      end
    end
        
end
