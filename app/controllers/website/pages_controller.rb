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
  
end
