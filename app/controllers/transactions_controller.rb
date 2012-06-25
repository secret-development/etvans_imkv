# -*- encoding : utf-8 -*-

class TransactionsController < ApplicationController

  respond_to :html
  before_filter :all_deny
  before_filter :time_work
  before_filter :check_fired
  before_filter :settings_deny, :only => :all
  before_filter :check_who_add, :only => :show
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource
  
  def index
    @transactions = Transaction.joins(:customer).search(params[:search]).order(sort_column + " " + sort_direction).where(:user_id => current_user.id).page(params[:page]).per(page_paginate)
    @title = "Мои сделки"
  end
  
  def all
    @transactions = Transaction.joins(:customer).search(params[:search]).order(sort_column + " " + sort_direction).page(params[:page]).per(page_paginate)
    @title = "Все сделки"
  end
  
  def new
    begin
      @customer = Customer.find(params[:customer_id])
      @transaction = Transaction.new
      @title = "Добавление новой сделки"
      respond_with @transaction
    rescue ActiveRecord::RecordNotFound
      redirect_to(transactions_path, :alert => "Нет привязанного клиента")
    end
  end
  
  def create
    @transaction = Transaction.new(params[:transaction])
    if @transaction.save
      flash[:notice] = "Сделка успешно добавлена"
      respond_with(@transaction)
    else
      render 'new'
    end
  end
  
  def show
    @transaction = Transaction.find(params[:id])
    @title = "Информация о сделке"
    respond_with @transaction
  end
  
  def edit
    @transaction = Transaction.find(params[:id])
    @title = "Редактирование сделки"
  end
  
  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update_attributes(params[:transaction])
      flash[:notice] = "Сделка успешно обновлена"
      redirect_to transactions_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    flash[:notice] = "Сделка успешно удалена"
    redirect_to transactions_path
  end
  
  def add_document
    @transaction = Transaction.find(params[:id])
    @title = "Добавление документов"
  end
  
  private
  
  def sort_column
    Transaction.column_names.include?(params[:sort]) ? params[:sort] : "created_at"    
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"    
  end
  
  def page_paginate
    if Paginator.find_by_resource("сделки")
      Paginator.find_by_resource("сделки").paginate
    else
      25
    end
  end
  
  def check_who_add
    @transaction = Transaction.find(params[:id])
    if current_user.id != @transaction.user_id && current_user.role != true
      redirect_to transactions_path, :alert => "Доступ к этой сделке запрещен"
    end
  end
  
end
