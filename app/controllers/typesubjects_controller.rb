# -*- encoding : utf-8 -*-

class TypesubjectsController < ApplicationController
  
  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  load_and_authorize_resource
  
  def index
    @typesubjects = Typesubject.all
    @title = "Типы недвижимости"
    respond_with(@typesubjects)
  end
  
  def new
    @typesubject = Typesubject.new
    @title = "Добавление типа"
    respond_with(@typesubject)
  end
  
  def edit
    @typesubject = Typesubject.find(params[:id])
    @title = "Редактирование типа"
    respond_with(@typesubject)
  end
  
  def create
    @typesubject = Typesubject.new(params[:typesubject])
    if @typesubject.save
      flash[:notice] = "Тип объекта успешно добавлен"
      respond_with(@typesubject, :location => typesubjects_path)
    else
      render 'new'
    end
  end
  
  def update
    @typesubject = Typesubject.find(params[:id])
    if @typesubject.update_attributes(params[:typesubject])
      flash[:notice] = "Тип объекта успешно обновлён"
      respond_with(@typesubject, :location => typesubjects_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @typesubject = Typesubject.find(params[:id])
    @typesubject.destroy
    flash[:notice] = "Тип объекта успешно удалён"
    redirect_to typesubjects_path
  end
  
end
