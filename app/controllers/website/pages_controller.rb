# -*- encoding : utf-8 -*-
class Website::PagesController < ApplicationController

  layout 'website'

  def index
    @w_title = "Империя квартир"
  end
  
  def about
    @w_title = "О компании"
  end
  
  def contacts
    @w_title = "Контакты"
  end
  
end
