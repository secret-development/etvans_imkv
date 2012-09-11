# -*- encoding : utf-8 -*-
class StatesController < ApplicationController

  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny

  load_and_authorize_resource
  
  def index
    @states = State.page(params[:page]).per(10)
    @title = "Информация о ЖК"
    respond_with(@states)
  end
  
  def show
    @state = State.find(params[:id])
    @title = @state.title
    respond_with(@state)
  end
  
  def new
    @state = State.new
    @title = "Добавление информации ЖК"
    respond_with(@state)
  end
  
  def edit
    @state = State.find(params[:id])
    @title = "Редактирвоание информации о ЖК"
    respond_with(@state)
  end
  
  def create
    @state = State.new(params[:state])
    if @state.save
      flash[:notice] = "Информация успешно сохранена"
      respond_with(@state, :location => e_states_path)
    else
      render 'new'
    end
  end
  
  def update
    @state = State.find(params[:id])
    if @state.update_attributes(params[:state])
      flash[:notice] = "Информация успешно обновлена"
      respond_with(@state, :location => e_states_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @state = State.find(params[:id])
    @state.destroy
    flash[:notice] = "Информация успешно удалена"
    redirect_to(e_states_path)
  end
  
end
