# -*- encoding : utf-8 -*-
require 'spec_helper'

describe SubjectsController do
  render_views
  
  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
    
    @customeraccess = FactoryGirl.create(:customeraccess)
    
    @city = FactoryGirl.create(:city)
    @typesubject = FactoryGirl.create(:typesubject)
    @typetransaction = FactoryGirl.create(:typetransaction)
    soc = FactoryGirl.create(:social_status)
    @customer = FactoryGirl.create(:customer, :typetransaction => @typetransaction, :social_status => soc)
    @district = FactoryGirl.create(:district)
    @resident = FactoryGirl.create(:resident)
    
    # main subject
    @subject = FactoryGirl.create(:subject, :typesubject => @typesubject, :city => @city,
                :typetransaction => @typetransaction, :customer => @customer, :district => @district, :resident => @resident, :user => @user)
  end
  
  it "get 'index'" do
    get :index
    response.should be_success
  end
  
  it "get new" do
    get :new
    response.should_not be_success
  end
  
  it "get new" do
    get :new, :customer_id => @customer
    response.should be_success
  end
  
  it "get edit" do
    get :edit, :id => @subject.id
    response.should be_success
  end
  
  it "get show" do
    get :show, :id => @subject
    response.should be_success
  end
  
  it "should have session[:customer_id]" do
    get :new, :customer_id => 3
    session[:customer_id].should eql("3")
  end
  
  it "get active" do
    get :active
    response.should be_success
  end
  
  it "get inactive" do
    get :inactive
    response.should be_success
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
        session[:customer_id] = @customer.id
      end
      
      it "should render the new page" do
        post :create, :subject => @attr 
        response.should render_template('new')
      end
      
      it "should not create a subject" do
        lambda do
          post :create, :subject => @attr
        end.should_not change(Subject, :count)
      end
    end
    
    describe "success without condition_fields" do
      before(:each) do
        @attr = valid_data
        session[:customer_id] = @customer.id
      end
      
      it "should redirect to show page" do
        post :create, :subject => @attr
        response.should redirect_to(assigns(:subject))
      end
      
      it "should create a subject" do
        lambda do
          post :create, :subject => @attr
        end.should change(Subject, :count).by(1)
      end
      
      it "should have a success message" do
        post :create, :subject => @attr
        flash[:notice].should =~ /Объект успешно создан/i
      end
    end
    
    describe "success when condition_fields > 0" do
      before(:each) do
        @typesubject_with_cond = FactoryGirl.create(:withcond)
        @condition = FactoryGirl.create(:condition_field, :typesubject => @typesubject_with_cond)
        @attr = properties_data
        session[:customer_id] = @customer.id
      end
      
      it "should redirect to add_properties" do
        post :create, :subject => @attr
        response.should redirect_to(add_properties_subject_path(assigns(:subject)))
      end
    end
  end
  
  
  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the edit page" do
        put :update, :id => @subject, :subject => @attr
        response.should render_template('edit')
      end
      
      it "should not create a subject" do
        lambda do
          put :update, :id => @subject, :subject => @attr
        end.should_not change(Subject, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect to show page" do
        put :update, :id => @subject, :subject => @attr
        response.should redirect_to(subject_path(assigns(:subject)))
      end
      
      it "should not create a subject" do
        lambda do
          put :update, :id => @subject, :subject => @attr
        end.should_not change(Subject, :count)
      end
      
      it "should have success message" do
        put :update, :id => @subject, :subject => @attr
        flash[:notice].should =~ /Объект успешно обновлён/i
      end
    end
  end
  
  describe "destroy" do
    it "should redirect_to subjects list page" do
      delete :destroy, :id => @subject
      response.should redirect_to(subjects_path)
    end
    
    it "should destroy the subject" do
      lambda do
        delete :destroy, :id => @subject
      end.should change(Subject, :count).by(-1)
    end
    
    it "should have success message" do
      delete :destroy, :id => @subject
      flash[:notice].should =~ /Объект успешно удалён/i
    end
  end
  
  describe "add_photo" do
    it "should be success" do
      get 'add_photo', :id => @subject
      response.should be_success
    end
  end
  
  describe "guest" do
    it "should be success" do
      get 'guest', :id => @subject
      response.should be_success
    end
  end
  
  # valid data
  def valid_data
    {
      :typesubject_id => @typesubject.id,
      :city_id => 2,
      :price => 100003,
      :district_id => @district.id,
      :resident_id => @resident.id,
      :area => 80,
      :address => "Баймагамбетова 15, 23",
      :customer_id => @customer,
      :floor => 5,
      :floorall => 9,
      :active => true,
      :price_currency => "доллар",
      :room => 4,
      :typetransaction_id => @typetransaction.id,
      :note => "Евроремонт",
      :user_id => @user.id
    }
  end
  
  # invalid data
  def invalid_data
    {
      :typesubject_id => @typesubject.id,
      :city_id => nil,
      :price => "swsws",
      :district_id => @district.id,
      :resident_id => @resident.id,
      :area => 80,
      :address => "Баймагамбетова 15, 23",
      :customer_id => @customer,
      :floor => 6,
      :floorall => 30,
      :room => 3,
      :active => true,
      :price_currency => "доллар",
      :typetransaction_id => @typetransaction.id,
      :note => "Норм квартира",
      :user_id => @user.id
    }   
  end
  
  def properties_data
    {
      :typesubject_id => @typesubject_with_cond.id,
      :city_id => 2,
      :price => 100003,
      :district_id => @district.id,
      :resident_id => @resident.id,
      :area => 80,
      :address => "Баймагамбетова 15, 23",
      :customer_id => @customer,
      :floor => 5,
      :floorall => 10,
      :room => 4,
      :active => true,
      :price_currency => "доллар",
      :typetransaction_id => @typetransaction.id,
      :note => "Не очень квартира",
      :user_id => @user.id
    }
  end
  
end
