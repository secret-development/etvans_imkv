# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::AdvicesController do
  
  render_views
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    
    @advice = Factory(:tip)
  end
  
  it "get :index" do
    get :index
    response.should be_success
  end
  
  it "get :show" do
    get :show, :id => @advice.id
    response.should be_success
  end
  
  it "get :new" do
    get :new
    response.should be_success
  end
  
  it "get :edit" do
    get :edit, :id => @advice.id
    response.should be_success
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the new page" do
        post :create, :advice => @attr
        response.should render_template("new")
      end
      
      it "should not create advice" do
        lambda do
          post :create, :adivce => @attr
        end.should_not change(Website::Advice, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect_to to advices path" do
        post :create, :advice => @attr
        response.should redirect_to(website_advices_path)
      end
      
      it "should create advice object" do
        lambda do
          post :create, :advice => @attr
        end.should change(Website::Advice, :count).by(1)
      end
      
      it "should have a success message" do
        post :create, :advice => @attr
        flash[:notice].should =~ /Совет успешно сохранён/i
      end
    end
  end
  
  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @advice.id, :advice => @attr
        response.should render_template('edit')
      end
      
      it "should not create advice object" do
        lambda do
          put :update, :id => @advice.id, :advice => @attr
        end.should_not change(Website::Advice, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect_to website_advices_path" do
        put :update, :id => @advice.id, :advice => @attr
        response.should redirect_to(website_advices_path)
      end
      
      it "should not create advice object" do
        lambda do
          put :update, :id => @advice.id, :advice => @attr  
        end.should_not change(Website::Advice, :count)
      end
      
      it "should success message" do
        put :update, :id => @advice.id, :advice => @attr
        flash[:notice].should =~ /Совет успешно обновлён/i
      end
    end
  end
  
  describe "DELET 'destroy'" do
    it "should redirect_to website_advices_path" do
      delete :destroy, :id => @advice
      response.should redirect_to(website_advices_path)
    end
    
    it "should destroy advice object" do
      lambda do
        delete :destroy, :id => @advice
        response.should redirect_to(website_advices_path)  
      end.should change(Website::Advice, :count).by(-1)
    end
    
    it "should success message" do
      delete :destroy, :id => @advice
      flash[:notice].should =~ /Совет успешно удалён/i
    end
  end
  
  
  def invalid_data
    {
      :title => "Первый пост",
      :body => nil,
      :author => "Труман"
    }
  end
  
  def valid_data
    {
      :title => "Второй пост",
      :body => "Раз два",
      :author => "Труман 2"
    }
  end
end
