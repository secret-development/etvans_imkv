# -*- encoding : utf-8 -*-

class PotentialsController < ApplicationController

  respond_to :html  
  before_filter :all_deny 
  before_filter :time_work
  before_filter :check_fired
  
  helper_method :sort_column, :sort_direction
  
  def index
    @potentials = Customer.potentials.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(page_paginate)
    @title = "Потенциальные клиенты"
  end
  
  def destroy
    @potentials = Customer.find(params[:id])
    @potentials.destroy
    flash[:notice] = "Клиент успешно удален"
    redirect_to @potentials    
  end
  
  private
  
  def sort_column
    Customer.column_names.include?(params[:sort]) ? params[:sort] : "id"    
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"    
  end
  
  def page_paginate
    if Paginator.find_by_resource("клиенты")
      Paginator.find_by_resource("клиенты").paginate
    else
      25
    end
  end
  
end
