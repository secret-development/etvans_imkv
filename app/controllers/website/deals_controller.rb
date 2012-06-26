# -*- encoding : utf-8 -*-
class Website::DealsController < ApplicationController
  respond_to :html
  layout 'website'
  
  def index
    @w_title = "Горячие предложения"
  end
end
