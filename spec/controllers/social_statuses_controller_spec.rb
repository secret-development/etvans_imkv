# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SocialStatusesController do
  render_views
  
  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
    @socialstatus = FactoryGirl.create(:social_status)
  end
  
  it "GET 'new'" do
    get :new
    response.should be_success      
  end
  
  it "GET 'index'" do
    get :index
    response.should be_success
  end
  
  it "GET 'edit'" do
    get :edit, :id => @socialstatus.id
    response.should be_success    
  end
  
  describe "POST create failture" do
    before(:each) do
      @attr = {:title => ""}
    end    
    it "should be not create" do
      lambda do
        post :create, :social_status => @attr
      end.should_not change(SocialStatus, :count)
    end   
  end
  
  describe "POST create successful" do
    before(:each) do
      @attr = {:title => "Рабочий"}
    end  
    it "should be create" do
      lambda do
        post :create, :social_status => @attr
      end.should change(SocialStatus, :count).by(1)      
    end
    
    it "should redirect to socialstatus index page" do
      post :create, :social_status => @attr
      response.should redirect_to(social_statuses_path)      
    end
    
    it "should have a message" do
      post :create, :social_status => @attr
      flash[:notice].should =~ /Социальный статус создан!/i      
    end    
  end
  
  describe "Update successful" do
    before(:each) do
      @attr = {:title => "Семейные"}
    end
    
    it "should be update" do
      lambda do
        put :update, :id => @socialstatus.id, :social_status => @attr
      end.should_not change(SocialStatus, :count)  
    end
    
    it "should redirect to socialstatus index page" do
      put :update, :id => @socialstatus.id, :social_status => @attr
      response.should redirect_to(social_statuses_path)      
    end
    
    it "should have a success message" do
      put :update, :id => @socialstatus.id, :social_status => @attr
      flash[:notice].should =~ /Социальный статус обновлен!/i      
    end    
  end
  
  describe "DELETE successful" do
  
    it "should redirect to socialstatus index page after delete" do
      delete :destroy, :id => @socialstatus.id
      response.should redirect_to(social_statuses_path)      
    end
    
    it "should be delete" do
      lambda do
        delete :destroy, :id => @socialstatus.id
      end.should change(SocialStatus, :count).by(-1)    
    end
    
    it "shoult have a success message" do
      delete :destroy, :id => @socialstatus.id
      flash[:notice].should =~ /Социальный статус удален!/i      
    end
  end 

  
end
