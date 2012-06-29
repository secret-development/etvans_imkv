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
  
  def create
    @state = Website::State.new(params[:website_state])
    if @state.save
      flash[:notice] = "Информация успешно сохранена"
      respond_with(@state, :location => website_states_path)
    else
      render 'new'
    end
  end
  
end
