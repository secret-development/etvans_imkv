# -*- encoding : utf-8 -*-

class ConditionFieldsController < ApplicationController

  respond_to :html
  before_filter :all_deny
  before_filter :settings_deny
  before_filter :load_typesubject, :only => [:index]
  load_and_authorize_resource
  
  def index
    @conditionfields = ConditionField.all
    @title = "Поля для недвижимости"
    respond_with(@conditionfields)
  end
  
  def new
    @conditionfield = ConditionField.new
    @title = "Добавление поля"
    respond_with(@conditionfield)
  end
  
  def edit
    @conditionfield = ConditionField.find(params[:id])
    @title = "Редактирование поля"
    respond_with(@conditionfield)
  end
  
  def create
    @conditionfield = ConditionField.new(params[:condition_field])
    if @conditionfield.save
      flash[:notice] = "Поле успешно добавлено"
      respond_with(@conditionfield, :location => condition_fields_path)
    else
      render 'new'
    end
  end
  
  def update
    @conditionfield = ConditionField.find(params[:id])
    if @conditionfield.update_attributes(params[:condition_field])
      flash[:notice] = "Поле успешно обновлено"
      respond_with(@conditionfield, :location => condition_fields_path)
    else
      render 'edit'
    end
  end
  
  def destroy
    @conditionfield = ConditionField.find(params[:id])
    @conditionfield.destroy
    flash[:notice] = "Поле успешно удалено"
    redirect_to condition_fields_path
  end
  
  def load_typesubject
    @typesubjects = []
    ConditionField.all.each { |c| @typesubjects << c.typesubject}
    @typesubjects.uniq!
    @typesubjects
  end
  
end
