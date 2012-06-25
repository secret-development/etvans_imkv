# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CitiesController do
  render_views
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    @city = Factory(:city)
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
    get :edit, :id => @city.id
    response.should be_success
  end

  describe "POST 'create' " do
    describe "failure" do
      before(:each) do
        @attr = { :name => ""}
      end
      
      it "should render the 'new' page" do
        post :create, :city => @attr
        response.should render_template('new')
      end
      
      it "should not create new city" do
        lambda do
          post :create, :city => @attr
        end.should_not change(City, :count)
      end
    end
    
    describe 'success' do
      before(:each) do
        @attr = {:name => "рудный"}
      end
      
      it "should redirect to cities" do
        post :create, :city => @attr
        response.should redirect_to(cities_path)
      end
      
      it "should change count un City model" do
        lambda do
          post :create, :city => @attr
        end.should change(City, :count).by(1)
      end
      
      it "should success flash" do
        post :create, :city => @attr
        flash[:notice].should =~ /Город успешно добавлен/i
      end
    end
  end
  
  describe "PUT update" do
    describe "failure" do
      before(:each) do
        @attr = {:name => ""}
      end
      
      it "should render edit" do
        put :update, :id => @city.id, :city => @attr
        response.should render_template('edit')
      end
      
      it "should not create new object" do
        lambda do
          put :update, :id => @city.id, :city => @attr
        end.should_not change(City, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = {:name => "Астана"}
      end
      
      it "should redirect to city path" do
        put :update, :id => @city.id, :city => @attr
        response.should redirect_to(cities_path)
      end
      
      it "should not create new object" do
        lambda do
          put :update, :id => @city.id, :city => @attr
        end.should_not change(City, :count)
      end
      
      it "should success message" do
        put :update, :id => @city.id, :city => @attr
        flash[:notice].should =~ /город успешно обновлён/i
      end
    end
  end
  
  describe "destroy" do
    
    it "should redirect to cities_path" do
      delete :destroy, :id => @city.id
      response.should redirect_to(cities_path)
    end
    
    it "should destroy city" do
      lambda do
        delete :destroy, :id => @city.id
      end.should change(City, :count).by(-1)
    end
    
    it "should success message" do
      delete :destroy, :id => @city.id
      flash[:notice].should =~ /город успешно удалён/i
    end
  end
end
