# -*- encoding : utf-8 -*-

class CustomersController < ApplicationController
  
  respond_to :html
  before_filter :all_deny
  before_filter :time_work
  before_filter :check_fired
  before_filter :agent_owner, :only => [:edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  
  def all
    @customers = Customer.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(page_paginate)
    @title = "Все клиенты"
  end
  
  def index
    @customers = Customer.real.search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(page_paginate)
    @title = "Действующие клиенты"
  end
  
  def new
    @customer = Customer.new
    @title = "Добавление клиента"
    3.times { @customer.phones.build }
    respond_with @customer 
  end
  
  def edit
    @customer = Customer.find(params[:id])
    @title = "Редактирование клиента"
    3.times { @customer.phones.build }
    respond_with @customer
    #unauthorized! if cannot? :update, @customer   
  end
  
  def show
    @customer = Customer.find(params[:id])
    @subjects = @customer.subjects
    @title = @customer.fullname
    respond_with @customer
  end
  
  def create
    @customer = Customer.create(params[:customer])
    if @customer.save
      flash[:notice] = "Клиент успешно сохранен!"
      respond_with(@customer)#, :location => customers_path)   
    else
      render 'new'      
    end    
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Клиент успешно обновлен"
      respond_with @customer   
    else
      render 'edit'     
    end    
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    flash[:notice] = "Клиент успешно удален"
    redirect_to @customer
  end
  
  def lastcallcustomer
    customer = Customer.find(params[:id])
    customer.update_attribute(:lastcall, Time.current)
    @lastcall = customer.lastcall.strftime('%d.%m.%Y %H:%M:%S').to_json
    respond_to do |format|
      format.json { render :json => @lastcall}
    end
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
  
  def agent_owner
    unless current_user.role == true
      customer = Customer.find(params[:id])
      unless current_user.id == customer.user_id
        flash[:alert] = "Данные клиент недоступен для вас"
        redirect_to customers_path
      end
    end
  end
  
end
