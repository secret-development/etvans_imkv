# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ValueFieldsController do
  render_views
  
  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
    @typesubject = FactoryGirl.create(:typesubject)
    @conditionfield = FactoryGirl.create(:condition_field, :typesubject => @typesubject)
    @valuefield = FactoryGirl.create(:value_field, :condition_field => @conditionfield)
    @attr = {
      :valuefield => "Нет",
      :condition_field_id => @conditionfield.id
    }
  end

  it "get index" do
    get :index
    response.should be_success
  end
  
  it "get new" do
    get :new
    response.should be_success
  end
  
  it "get edit" do
    get :edit, :id => @valuefield.id
    response.should be_success
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the 'new' page" do
        post :create, :value_field => @attr
        response.should render_template('new')
      end
      
      it "should not create valuefield" do
        lambda do
          post :create, :value_field => @attr  
        end.should_not change(ValueField, :count)
      end
      
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect_to valuesfields path" do
        post :create, :value_field => @attr
        response.should redirect_to(value_fields_path)
      end
      
      it "should create valuefield object" do
        lambda do
          post :create, :value_field => @attr
        end.should change(ValueField, :count).by(1)
      end
      
      it "should success flash msg" do
        post :create, :value_field => @attr
        flash[:notice].should =~ /Значение успешно добавлено/i
      end
    end
  end
  
  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the edit template" do
        put :update, :id => @valuefield.id,
            :value_field => @attr
        response.should render_template('edit')
      end
      
      it "should not create a valuefield" do
        lambda do
          put :update, :id => @valuefield.id,
              :value_field => @attr          
        end.should_not change(ValueField, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect to value_fields_path" do
        put :update, :id => @valuefield.id,
            :value_field => @attr
        response.should redirect_to(value_fields_path)
      end
      
      it "should not create value_field object" do
        lambda do
          put :update, :id => @valuefield.id,
              :value_field => @attr
        end.should_not change(ValueField, :count)
      end
      
      it "should success message" do
        put :update, :id => @valuefield.id,
            :value_field => @attr
        flash[:notice].should =~ /Значение успешно обновлено/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    it "should redirect to value_fields_path" do
      delete :destroy, :id => @valuefield.id
      response.should redirect_to(value_fields_path)
    end
    
    it "should destroy the value_field" do
      lambda do
        delete :destroy, :id => @valuefield.id
      end.should change(ValueField, :count).by(-1)
    end
    
    it "should success message" do
      delete :destroy, :id => @valuefield.id
      flash[:notice].should =~ /Значение успешно удалено/i
    end
  end
  
  
  def valid_data
    {
      :valuefield => "Нет",
      :condition_field_id => @conditionfield.id  
    }
    
  end
  
  def invalid_data
    {
      :valuefield => "",
      :condition_field_id => ""
    }
  end
  
end
