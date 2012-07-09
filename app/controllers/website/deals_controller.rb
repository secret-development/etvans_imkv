# -*- encoding : utf-8 -*-
class Website::DealsController < ApplicationController
  respond_to :html
  layout 'website'
  
  def index
    @w_title = "Горячие предложения"
    @subjects = Kaminari.paginate_array(Subject.where(:active => true).last(40).reverse).page(params[:page]).per(5)
    
    respond_with(@subjects)
  end
end
