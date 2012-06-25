# -*- encoding : utf-8 -*-
#encoding: UTF-8

require 'spec_helper'

describe TasksController do
  render_views
  
  before(:each) do
    
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    
    @task = Factory(:task, :user => @user, :user_lastname => @user.lastname)
  end
  
  it "get show" do
    get :show, :id => @task
    response.should be_success
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
    get :edit, :id => @task.id
    response.should be_success
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the 'new' page" do
        post :create, :task => @attr
        response.should render_template('new')
      end
      
      it "should not create a task" do
        lambda do
          post :create, :task => @attr
        end.should_not change(Task, :count)
      end
      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = valid_data
      end
      
      it "should create a task" do
        lambda do
          post :create, :task => @attr
        end.should change(Task, :count).by(1)
      end
      
      it "should redirect to the task page" do
        post :create, :task => @attr
        response.should redirect_to(task_path(assigns(:task)))
      end
      
      it "should have a success message" do
        post :create, :task => @attr
        flash[:notice].should =~ /Задача успешно добавлена/i
      end
      
    end
    
  end
  
  describe "PUT 'update'" do
    
    describe "failure update" do
      
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @task.id, :task => @attr
        response.should render_template('edit')
      end
      
      it "should not update a task" do
        lambda do
          put :update, :id => @task.id, :task => @attr
        end.should_not change(Task, :count)
      end
            
    end
    
    describe "success update" do
      
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect to tasks" do
        put :update, :id => @task.id, :task => @attr
        response.should redirect_to tasks_path
      end
      
      it "should not create a task" do
        lambda do
          put :update, :id => @task.id, :task => @attr
        end.should_not change(Task, :count)
      end
      
      it "should have a success message" do
        put :update, :id => @task.id, :task => @attr
        flash[:notice].should =~ /Задача успешно обновлена/i
      end
      
    end
    
  end
  
  describe "DELETE 'destroy'" do
    
    it "should redirect to tasks" do
      delete :destroy, :id => @task.id
      response.should redirect_to tasks_path
    end
    
    it "should destroy the task" do
      lambda do
        delete :destroy, :id => @task.id
      end.should change(Task, :count).by(-1)
    end
    
    it "should have a success message" do
      delete :destroy, :id => @task.id
      flash[:notice] =~ /Задача успешно уделена/i
    end
    
  end
  
  def valid_data
    {
      :title => "MyString",
      :description => "MyText",
      :user_id => @user.id,
      :deadline => "2050-02-08 13:58:15",
      :done => false,
      :user_lastname => @user.lastname
    }
  end
  
  def invalid_data
    {
      :title => "",
      :description => "",
      :user_id => @user.id,
      :deadline => "",
      :done => false,
      :user_lastname => @user.lastname
    }
  end
  
end
