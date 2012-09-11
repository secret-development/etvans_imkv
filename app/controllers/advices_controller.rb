# -*- encoding : utf-8 -*-
class AdvicesController < ApplicationController
    
  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  
  load_and_authorize_resource
  
  def index
    @advices = Advice.page(params[:page]).per(10)
    @title = "Советы"
    respond_with(@advices)
  end
  
  def show
    @advice = Advice.find(params[:id])
    @title = @advice.title
    respond_with(@advice)
  end
  
  def new
    @advice = Advice.new
    @title = "Добавление совета"
    respond_with(@advice)
  end
  
  def create
    @advice = Advice.new(params[:advice])
    if @advice.save
      flash[:notice] = "Совет успешно сохранён"
      respond_with(@advice, :location => e_advices_path)
    else
      render 'new'
    end
  end
  
  def edit
    @advice = Advice.find(params[:id])
    @title = "Редактирование совета"
    respond_with(@advice)
  end
  
  def update
    @advice = Advice.find(params[:id])
    if @advice.update_attributes(params[:advice])
      flash[:notice] = "Совет успешно обновлён"
      respond_with(@advice, :location => e_advices_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @advice = Advice.find(params[:id])
    @advice.destroy
    flash[:notice] = "Совет успешно удалён"
    redirect_to e_advices_path
  end
end
