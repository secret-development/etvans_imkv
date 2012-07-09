# -*- encoding : utf-8 -*-
class Website::SubjectController < ApplicationController
  respond_to :html
  layout 'website'
  helper :all
  
  def show
    @subject = Subject.find(params[:id])
    @w_title = "#{@subject.typesubject.name} в городе '#{@subject.city.name}'."
    respond_with(@subject)
  end
end
