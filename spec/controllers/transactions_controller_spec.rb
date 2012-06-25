# -*- encoding : utf-8 -*-
#encoding: UTF-8

require 'spec_helper'

describe TransactionsController do
  render_views
  
  before(:each) do
    # login
    @user = Factory(:user)
    test_log_in(@user)
    # end login
    
    @typetransaction = Factory(:typetransaction)

    city = Factory(:city)
    @typesubject = Factory(:typesubject)
    @customer = Factory(:customer)
    @district = Factory(:district)
    @subject = Factory(:subject, :typesubject => @typesubject, :city => city,
              :typetransaction => @typetransaction, :customer => @customer,
              :district => @district)

    @transaction = Factory(:transaction, :typetransaction => @typetransaction,
                  :user => @user, :user_lastname => @user.lastname, 
                  :customer => @customer, :subject => @subject)
                  
  end
  
  it "get show" do
    get :show, :id => @transaction.id
    response.should be_success
  end
  
  it "get index" do
    get :index
    response.should be_success
  end
  
  it "get new (without identificators)" do
    get :new
    response.should_not be_success
  end
  
  it "get new" do
    get :new, :user_id => @user, :customer_id => @customer, 
              :typetransaction_id => @typetransaction,
              :subject_id => @subject
    response.should be_success
  end
  
  it "ged edit" do
    get :edit, :id => @transaction.id
    response.should be_success
  end
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render 'new' page" do
        post :create, :transaction => @attr
        response.should render_template('new')
      end
      
      it "should not create a transaction" do
        lambda do
          post :create, :transaction => @attr
        end.should_not change(Transaction, :count)
      end
      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect to transaction page" do
        post :create, :transaction => @attr
        response.should redirect_to(transaction_path(assigns(:transaction)))
      end
      
      it "should create a transaction" do
        lambda do
          post :create, :transaction => @attr
        end.should change(Transaction, :count).by(1)
      end
      
      it "should have a success message" do
        post :create, :transaction => @attr
        flash[:notice].should =~ /Сделка успешно добавлена/
      end
      
    end
    
  end
  
  describe "PUT 'update'" do
    
    describe "failure" do
      
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the 'edit' page" do
        put :update, :id => @transaction, :transaction => @attr
        response.should render_template('edit')
      end
      
      it "should not create a transaction" do
        lambda do
          put :update, :id => @transaction, :transaction => @attr
        end.should_not change(Transaction, :count)
      end
      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect to transactions page" do
        put :update, :id => @transaction, :transaction => @attr
        response.should redirect_to transactions_path
      end
      
      it "should not create a transaction" do
        lambda do
          put :update, :id => @transaction, :transaction => @attr
        end.should_not change(Transaction, :count)
      end
      
      it "should have success message" do
        put :update, :id => @transaction, :transaction => @attr
        flash[:notice].should =~ /Сделка успешно обновлена/i
      end
      
    end
    
  end
  
  describe "destroy" do
    
    it "should redirect to transactions page" do
      delete :destroy, :id => @transaction
      response.should redirect_to transactions_path
    end
    
    it "should destroy the transaction" do
      lambda do
        delete :destroy, :id => @transaction
      end.should change(Transaction, :count).by(-1)
    end
    
    it "should have success message" do
      delete :destroy, :id => @transaction
      flash[:notice].should =~ /Сделка успешно удалена/i
    end
    
  end
  
  describe "add_document" do
    
    it "should be success" do
      get 'add_document', :id => @transaction
      response.should be_success
    end
    
  end
  
  #valid_data
  def valid_data
    {
      :name => "name",
      :description => "description",
      :price => 1000,
      :payment => false,
      :user_id => @user.id,
      :user_lastname => @user.lastname,
      :customer_id => @customer.id,
      :subject_id => @subject.id,
      :typetransaction_id => @typetransaction.id,
      :price_currency => "доллар"
    }
  end
  
  #invalid_data
  def invalid_data
    {
      :name => "",
      :description => "",
      :price => 1000,
      :payment => false,
      :user_id => @user.id,
      :user_lastname => @user.lastname,
      :customer_id => @customer.id,
      :subject_id => @subject.id,
      :typetransaction_id => @typetransaction.id,
      :price_currency => "доллар"
    }
  end
  
end
