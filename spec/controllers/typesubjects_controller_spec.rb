# -*- encoding : utf-8 -*-
require 'spec_helper'

describe TypesubjectsController do
  
  render_views
  
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    
    @typesubject = Factory(:typesubject)
  end
  
  it "get :index" do
    get :index
    response.should be_success
  end
  
  it "get :new" do
    get :new
    response.should be_success
  end
  
  it "get :edit" do
    get :edit, :id => @typesubject.id
    response.should be_success
  end
  
  describe "POST 'create'" do
    describe "failure" do
      
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the new page" do
        post :create, :typesubject => @attr
        response.should render_template('new')
      end
      
      it "should not create a typesubject" do
        lambda do
          post :create, :typesubject => @attr
        end.should_not change(Typesubject, :count)
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect_to to typesubjects path" do
        post :create, :typesubject => @attr
        response.should redirect_to(typesubjects_path)
      end
      
      it "should create typesubject" do
        lambda do
          post :create, :typesubject => @attr
        end.should change(Typesubject, :count).by(1)
      end
      
      it "should have a success message" do
        post :create, :typesubject => @attr
        flash[:notice].should =~ /Тип объекта успешно добавлен/i
      end
    end
  end
  
  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @typesubject.id,
            :typesubject => @attr
        response.should render_template('edit')
      end
      
      it "should not create typesubject object" do
        lambda do
          put :update, :id => @typesubject.id,
               :typesubject => @attr
        end.should_not change(Typesubject, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect to typesubjects_path" do
        put :update, :id => @typesubject.id,
            :typesubject => @attr
        response.should redirect_to(typesubjects_path)
      end
      
      it "should not create typesubject" do
        lambda do
          put :update, :id => @typesubject.id,
              :typesubject => @attr  
        end.should_not change(Typesubject, :count)
      end
      
      it "should success message" do
        put :update, :id => @typesubject.id,
            :typesubject => @attr
        flash[:notice].should =~ /Тип объекта успешно обновлён/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    it "should redirect_to typesubjects_path" do
      delete :destroy, :id => @typesubject
      response.should redirect_to(typesubjects_path)
    end
    
    it "should destroy the typesubject" do
      lambda do
        delete :destroy, :id => @typesubject
      end.should change(Typesubject, :count).by(-1)
    end
    
    it "should success message" do
      delete :destroy, :id => @typesubject
      flash[:notice].should =~ /Тип объекта успешно удалён/i
    end
  end
  
  
  def invalid_data
    {
      :name => "Дом",
      :permalink => "",
      :floor => nil,
      :room => true,
      :resident => true,
    }
  end
  
  def valid_data
    {
      :name => "Земля",
      :permalink => "terrain",
      :floor => true,
      :room => true,
      :resident => true
    }
  end
  
end
