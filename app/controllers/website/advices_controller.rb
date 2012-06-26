# -*- encoding : utf-8 -*-
class Website::AdvicesController < ApplicationController
  
  respond_to :html
  before_filter :all_deny, :except => [:index]
  load_and_authorize_resource
  
  def index
    @advices = Website::Advice.page(params[:page]).per(5)
    @title = "Советы"
    respond_with(@advices)
  end
  
  def admin_index
    @advices = Website::Advice.page(params[:page]).per(5)
    @title = "Советы"
    respond_with(@advices)
  end
  
  def show
    @advice = Website::Advice.find(params[:id])
    @title = @advice.title
    respond_with(@advice)
  end
  
  def new
    @advice = Website::Advice.new
    @title = "Добавление совета"
    respond_with(@advice)
  end
  
  def create
    @advice = Website::Advice.new(params[:advice])
    if @advice.save
      flash[:notice] = "Совет успешно сохранён"
      respond_with(@advice, :location => advices_path)
    else
      render 'new'
    end
  end
  
  def edit
    @advice = Website::Advice.find(params[:id])
    @title = "Редактирование совета"
    respond_with(@advice)
  end
  
  def update
    @advice = Website::Advice.find(params[:id])
    if @advice.update_attributes(params[:advice])
      flash[:notice] = "Совет успешно обновлён"
      respond_with(@advice, :location => advices_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @advice = Website::Advice.find(params[:id])
    @advice.destroy
    flash[:destroy] = "Совет успешно удален"
    redirect_to advices_path
  end
end