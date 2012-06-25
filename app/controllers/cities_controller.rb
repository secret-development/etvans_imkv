# -*- encoding : utf-8 -*-

class CitiesController < ApplicationController
  
  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  load_and_authorize_resource
  
  def index
    @cities = City.all
    @title = "Города"
    respond_with @cities
  end
  
  def new
    @city = City.new
    @title = "Добавление города"
    respond_with @city
  end
  
  def edit
    @city = City.find(params[:id])
    @title = "Редактирование города"
    respond_with @city
  end
  
  def create
    @city = City.new(params[:city])
    if @city.save
      flash[:notice] = "Город успешно добавлен"
      respond_with(@city, :location => cities_path)
    else
      render 'new'
    end
  end
  
  def update
    @city = City.find(params[:id])
    if @city.update_attributes(params[:city])
      flash[:notice] = "Город успешно обновлён"
      respond_with(@city, :location => cities_path)
    else
      render 'edit'
    end    
  end
  
  def destroy
    @city = City.find(params[:id])
    @city.destroy
    redirect_to cities_path
    flash[:notice] = "Город успешно удалён"
  end
end
