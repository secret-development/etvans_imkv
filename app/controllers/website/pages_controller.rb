# -*- encoding : utf-8 -*-
class Website::PagesController < ApplicationController

  respond_to :html
  layout 'website'

  def index
    @w_title = "Поиск"
    @search = Subject.search(params[:search])
    if params[:search]
      @subjects = @search.page(params[:page]).per(2)
      if @subjects.size == 0
        flash.now[:alert] = "Ничего не найдено"
      end
      respond_with(@subjects)
    end
  end
  
  def about
    @w_title = "О компании"
  end
  
  def contacts
    @w_title = "Контакты"
  end
  
  # advices:
  
  def advices
    @w_title = "Полезные советы"
    @advices = Advice.page(params[:page]).per(5)
    respond_with(@advices)
  end
  
  def show_advice
    @advice = Advice.find(params[:id])
    @w_title = @advice.title
    respond_with(@advice)
  end
  
  # states
  
  def states
    @w_title = "Информация по ЖК"
    @states = State.page(params[:page]).per(5)
    respond_with(@states)
  end
  
  def show_state
    @state = State.find(params[:id])
    @w_title = @state.title
    respond_with(@state)
  end
  
  # all subjects
  def all_subjects
    @w_title = "Вся недвижимость"
    @allsubjects = Kaminari.paginate_array(Subject.all.reverse).page(params[:page]).per(15)
  end
  
end
