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
  
  it "get :admin_index" do
    get :admin_index
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
