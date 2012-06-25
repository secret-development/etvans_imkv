# -*- encoding : utf-8 -*-
class Website::SubjectController < ApplicationController
  respond_to :html
  layout 'website'
  
  def show
    @subject = Subject.find(params[:id])
    @title = @subject.typesubject.name
    respond_with(@subject)
  end
end
