# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Website::StatesController do
  render_views
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    
    @state = Factory(:state)
  end
  
  describe "success requests" do
    it "get :index" do
      get :index
      response.should be_success
    end
    
    it "get :show" do
      get :show, :id => @state.id
      response.should be_success
    end
    
    it "get :new" do
      get :new
      response.should be_success
    end
    
    it "get :edit" do
      get :edit, :id => @state.id
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the new page" do
        post :create, :website_state => @attr
        response.should render_template('new')
      end
      
      it "should not create the state object" do
        lambda do
          post :create, :website_state => @attr
        end.should_not change(Website::State, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect_to index path" do
        post :create, :website_state => @attr
        response.should redirect_to(website_states_path)
      end
      
      it "should create state object" do
        lambda do
          post :create, :website_state => @attr
        end.should change(Website::State, :count).by(1)
      end
      
      it "should have a success message" do
        post :create, :website_state => @attr
        flash[:notice].should =~ /Информация успешно сохранена/i
      end
    end
    
  end
  
  
  def valid_data
    {
      :title => "Инфинити",
      :description => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      :address => "Валиханова"
    }
  end
  
  def invalid_data
    {
      :title => "Радуга",
      :description => nil,
      :address => "Дида"  
    }
  end
  
end