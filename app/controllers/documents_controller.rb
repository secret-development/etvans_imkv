# -*- encoding : utf-8 -*-

class DocumentsController < ApplicationController  

  before_filter :find_transaction
  before_filter :find_or_build_document
  skip_before_filter :verify_authenticity_token
  
  def create
    respond_to do |format|
      unless @document.save
        flash[:error] = "К сожалению, загрузить документ не удалось"
      end
      format.js do
        render :text => render_to_string(:partial => "documents/document", :locals => {:document => @document})
      end
    end
  end
  
  def destroy
    respond_to do |format|
      unless @document.destroy
        flash[:error] = "К сожалению, удалить документ не удалось"
      end
      format.js
    end
  end
  
  private
    
    def find_transaction
      @transaction = Transaction.find(params[:transaction_id])
      raise ActiveRecord::RecordNotFound unless @transaction
    end
    
    def find_or_build_document
      @document = params[:id] ? @transaction.documents.find(params[:id]) : @transaction.documents.build(params[:document])
    end
    
end
