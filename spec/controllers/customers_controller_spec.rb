# -*- encoding : utf-8 -*-
require 'spec_helper'

describe CustomersController do
  render_views
  
  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
    @attr = {
      :firstname => "vano", 
      :lastname => "vanov", 
      :phonehome => "1243", 
      :phonemobile => "876965",
      :email => "sam@mail.ru",
      :potentials => false,
      :note => "blabla",
      :lastcall => Time.now.weeks_ago(1),
      :user_id => @user.id
    }
    
    @customeraccess = FactoryGirl.create(:customeraccess)
    
    soc = FactoryGirl.create(:social_status)
    typetr = FactoryGirl.create(:typetransaction)
    @customer = FactoryGirl.create(:customer, :typetransaction => typetr, :social_status => soc, :user => @user)
    
    # subject factory
    city = FactoryGirl.create(:city)
    @typesubject = FactoryGirl.create(:typesubject)
    typetransaction = FactoryGirl.create(:typetransaction)
    @district = FactoryGirl.create(:district)
    @subject = FactoryGirl.create(:subject, :typesubject => @typesubject, :city => city,
                :typetransaction => typetransaction, :customer => @customer, :district => @district)
    # subject factory

  end

  describe "GET should be successful" do
    it "'new'" do
      get :new
      response.should be_success
    end   
      
    it "'index'" do
      get :index
      response.should be_success       
    end
    
    it "'add" do
      get :all
      response.should be_success
    end
  
    it "'edit'" do
      get :edit, :id => @customer
      response.should be_success
    end
  
    it "'show'" do
      get :show, :id => @customer
      response.should be_success    
    end
  end
  
  describe "Post success" do
    before(:each) do
      @attr = {:firstname => "vano", :lastname => "vanov", :phonehome => "1243", :phonemobile => "876965" }
    end
    
    it "should create" do
      lambda do
        post :create, :customer => @attr
      end.should change(Customer, :count).by(1) 
    end
    
    it "should redirect to the customer_path" do
      post :create, :customer => @attr
      response.should redirect_to(customer_path(assigns(:customer)))
      #response.should redirect_to :action => :show, :id => assigns(:customer).id       
    end
    
    it "should have a flash success message" do
      post :create, :customer => @attr
      flash[:notice].should =~ /Клиент успешно сохранен!/
    end     
  end
  
  describe "POST 'lastcallcustomer'" do
    it "should not create customer" do
      lambda do
        post :lastcallcustomer, :id => @customer.id,
            :lastcall => Time.now
      end.should_not change(Customer, :count)
    end
  end
  
  describe "scope should be show potentials and real customers" do
    before(:each) do
      @potential =  {:firstname => "vano", :lastname => "vanov", :phonehome => "1243", :phonemobile => "876965" }
      @real = {:firstname => "vano", :lastname => "vanov", :phonehome => "1243", :phonemobile => "876965", :potentials => false }
    end
    
#    it "success" do
#      post :create, :customer => @real
#      post :create, :customer => @potential
#        
#    end    
  end
end

