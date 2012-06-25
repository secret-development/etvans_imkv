# -*- encoding : utf-8 -*-
class DistrictsController < ApplicationController
  
  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  load_and_authorize_resource
  
  def index
    @title = "Районы"
    @cities = City.all
    respond_with(@cities)
  end
  
  def edit
    @district = District.find(params[:id])
    @title = "Редактирование района"
    respond_with(@district)
  end
  
  def update
    @district = District.find(params[:id])
    if @district.update_attributes(params[:district])
      flash[:notice] = "Район успешно обновлён"
      respond_with(@district, :location => districts_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @district = District.find(params[:id])
    @district.destroy
    flash[:notice] = "Район успешно удалён"
    redirect_to districts_path
  end
  
end
