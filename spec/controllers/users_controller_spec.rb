# -*- encoding : utf-8 -*-
require 'spec_helper'

describe UsersController do
  
  describe "admin user" do
    before(:each) do
      # start auth
      @user = Factory(:user)
      test_log_in(@user)
      # end auth
      @new_user = { 
                :lastname => "Горбунов",
                :firstname => "Анатолий",
                :email => "gor@mail.ru",
                :password => "password",
                :password_confirmation => "password",
                :phonemobile => "+7 777 747 4343",
                :fired => false
      }
    end

    describe "returns http success" do
      it "GET 'new'" do
        get :new
        response.should be_success
      end
    
      it "GET 'edit'" do
        get :edit, :id => @user.id
        response.should be_success      
      end
    
      it "GET 'index'" do
        get :index
        response.should be_success      
      end
    end
  
    #post create
    describe "POST 'create'" do
    
      describe "success" do      
        it "create" do
          lambda do
            post :create, :user => @new_user
          end.should change(User, :count).by(1) 
        end 
      
        it "should redirect to users_path" do
          post :create, :user => @new_user
          response.should redirect_to(users_path)        
        end
      
        it "should have a successful message" do
          post :create, :user => @new_user
          flash[:notice].should =~ /Сотрудник создан/i        
        end     
      end  
    end
  end
  
  describe "regular user" do
    before(:each) do  
      @regular_user = Factory(:regular_user) 
      test_log_in(@regular_user)
      @other = Factory(:user)
      @attr = { :email => "agent007@mail.ru"}
    end
      
    describe "cannot regular user" do
      it "GET 'new'" do
        get :new
        response.should_not be_success          
      end
      
      it "should redirect root path" do
        put :update, :id => @other, :user => @attr
        flash[:alert].should =~ /Действия запрещены!/i        
      end
    end
    
    describe "can regular user" do
      it "update self" do
        put :update, :id => @regular_user, :user => @attr
        flash[:notice].should =~ /Данные изменены/i      
      end
    end    
  end
  
  describe "destroy" do
    before(:each) do
      @user_d = Factory(:user)
      test_log_in(@user_d)
      @user_d2 = Factory(:user2)
      test_log_in(@user_d2)
    end
    
    it "should redirect_to list users" do
      delete :destroy, :id => @user_d
      response.should redirect_to(users_path)
    end
    
    it "should have a flash success message" do
      delete :destroy, :id => @user_d
      flash[:notice].should =~ /Сотрудник уволен/
    end
    
    it "should not destroy the user" do
      lambda do
        delete :destroy, :id => @user_d
      end.should_not change(User, :count)
    end
    
    it "should fired = true" do
      post :destroy, :id => @user_d2
      @user_d2.fired.should == true
    end
  end

end
