# -*- encoding : utf-8 -*-

class ValueFieldsController < ApplicationController

  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  before_filter :load_typesubject, :only => [:index]
  load_and_authorize_resource
  
  def index
    @valuefields = ValueField.all
    @title = "Значения для дополнительных полей"
    respond_with(@valufields)
  end
  
  def new
    @valuefield = ValueField.new
    @title = "Добавление значений для доп.полей"
    respond_with(@valuefield)
  end
  
  def edit
    @valuefield = ValueField.find(params[:id])
    @title = "Редактирование значения"
    respond_with(@valuefield)
  end
  
  def create
    @valuefield = ValueField.new(params[:value_field])
    if @valuefield.save
      flash[:notice] = "Значение успешно добавлено"
      respond_with(@valuefield, :location => value_fields_path)
    else
      render 'new'
    end
  end
  
  def update
    @valuefield = ValueField.find(params[:id])
    if @valuefield.update_attributes(params[:value_field])
      flash[:notice] = "Значение успешно обновлено"
      respond_with(@valuefield, :location => value_fields_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @valuefield = ValueField.find(params[:id])
    @valuefield.destroy
    flash[:notice] = "Значение успешно удалено"
    redirect_to value_fields_path
  end
  
  def load_typesubject
    @typesubjects = []
    ValueField.all.each { |v| @typesubjects << v.condition_field.typesubject}
    @typesubjects.uniq!
  end
  
  
end
