# -*- encoding : utf-8 -*-
class ReportsController < ApplicationController

  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  layout 'report'
  load_and_authorize_resource
  
  def index
    redirect_to finance_reports_path
  end
  
  def show
  end
  
  def general
    if params[:period] == "Неделя" and params[:objects] == "Клиенты"
      render "customers_week"
    elsif params[:period] == "Месяц" and params[:objects] == "Клиенты"
      render "customers_month"
    elsif params[:period] == "Квартал" and params[:objects] == "Клиенты"
      render "customers_quarter"
    elsif params[:period] == "Год" and params[:objects] == "Клиенты"
      render "customers_year"
    elsif params[:period] == "Неделя" and params[:objects] == "Объекты"
      render "subjects_week"
    elsif params[:period] == "Месяц" and params[:objects] == "Объекты"
      render "subjects_month"
    elsif params[:period] == "Квартал" and params[:objects] == "Объекты"
      render "subjects_quarter"
    elsif params[:period] == "Год" and params[:objects] == "Объекты"
      render "subjects_year"      
    end
  end
  
  def activ
    if params[:period] == "Неделя" #and params[:agent] # [:agent_id] == Report.current(:agent_id)
      Report.find_user(params[:agent][:agent_id])
      render "activ_week"
    elsif params[:period] == "Месяц" #and params[:agent_id]
      Report.find_user(params[:agent][:agent_id])
      render "activ_month"
    elsif params[:period] == "Квартал" #and params[:agent_id]
      Report.find_user(params[:agent][:agent_id])
      render "activ_quarter"
    elsif params[:period] == "Год" #and params[:agent_id]
      Report.find_user(params[:agent][:agent_id])
      render "activ_year"                      
    end      
  end
  
  def finance
    if params[:period] == "Неделя"
      render  "weeks"
    elsif params[:period] == "Месяц"
      render  "month"
    elsif params[:period] == "Квартал"
      render "quarter"
    elsif params[:period] == "Год"
      render "year"      
    end     
  end
end
