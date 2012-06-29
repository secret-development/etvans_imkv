# -*- encoding : utf-8 -*-
class Website::StatesController < ApplicationController

  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  
  def index
    @states = Website::State.page(params[:page]).per(10)
    @title = "Информация о ЖК"
    respond_with(@states)
  end
  
  def show
    @state = Website::State.find(params[:id])
    @title = @state.title
    respond_with(@state)
  end
  
  def new
    @state = Website::State.new
    @title = "Добавление информации ЖК"
    respond_with(@state)
  end
  
  def edit
    @state = Website::State.find(params[:id])
    @title = "Редактирвоание информации о ЖК"
    respond_with(@state)
  end
  
end
