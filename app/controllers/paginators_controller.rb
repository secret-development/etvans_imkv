# -*- encoding : utf-8 -*-
class PaginatorsController < ApplicationController
  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  load_and_authorize_resource
  
  def index
    @paginators = Paginator.all
    @title = "Постраничный вывод"
    respond_with(@paginators)
  end
  
  def edit
    @paginator = Paginator.find(params[:id])
    @title = "Редактирование"
    respond_with(@paginator)
  end
  
  def update
    @paginator = Paginator.find(params[:id])
    if @paginator.update_attributes(params[:paginator])
      flash[:notice] = "Постраничный вывод успешно обновлен"
      respond_with(@paginator, location: paginators_path)
    else
      render 'edit'
    end
  end
  
end
