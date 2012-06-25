# -*- encoding : utf-8 -*-

class PhotosController < ApplicationController

  before_filter :find_subject
  before_filter :find_or_build_photo
  skip_before_filter :verify_authenticity_token
  
  def create
    respond_to do |format|
      unless @photo.save
        flash[:error] = "К сожалению, изображение не загрузилось"
      end
      format.js do
        render :text => render_to_string(:partial => "photos/photo", :locals => {:photo => @photo})
      end
    end
  end
  
  def destroy
    respond_to do |format|
      unless @photo.destroy
        flash[:error] = "К сожалению, изображение не удалилось"
      end
      format.js
    end
  end
  
  private
    
    def find_subject
      @subject = Subject.find(params[:subject_id])
      raise ActiveRecord::RecordNotFound unless @subject
    end
    
    def find_or_build_photo
      @photo = params[:id] ? @subject.photos.find(params[:id]) : @subject.photos.build(params[:photo])
    end
end
