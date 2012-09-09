# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ResidentsController do
  render_views
  
  before(:each) do
    # start auth
    @user = FactoryGirl.create(:user)
    test_log_in(@user)
    # end auth
    @city = FactoryGirl.create(:city)
    @resident = FactoryGirl.create(:resident, :city => @city)
  end
  
  it "get 'index'" do
    get :index
    response.should be_success
  end

  it "get 'edit'" do
    get :edit, :id => @resident
    response.should be_success
  end
  
  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the edit page" do
        put :update, :id => @resident, :resident => @attr
        response.should render_template('edit')
      end
      
      it "should not create the resident" do
        lambda do
          put :update, :id => @resident, :resident => @attr
        end.should_not change(Resident, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect_to residents list page" do
        put :update, :id => @resident, :resident => @attr
        response.should redirect_to(residents_path)
      end
      
      it "should not create the resident object" do
        lambda do
          put :update, :id => @resident, :resident => @attr
        end.should_not change(Resident, :count)
      end
      
      it "should have success message" do
        put :update, :id => @resident, :resident => @attr
        flash[:notice].should =~ /ЖК успешно обновлён/i
      end
    end
  end
  
  describe "destroy" do
    
    it "should redirect to residents list page" do
      delete :destroy, :id => @resident
      response.should redirect_to(residents_path)
    end
    
    it "should destroy the resident" do
      lambda do
        delete :destroy, :id => @resident
      end.should change(Resident, :count).by(-1)
    end
    
    it "should have success message" do
      delete :destroy, :id => @resident
      flash[:notice].should =~ /ЖК успешно удалён/i
    end
  end
  
  def valid_data
    {
      :city_id => @city.id,
      :title => "Радуга"
    }
  end

  def invalid_data
    {
      :city_id => @city.id,
      :title => nil
    }
  end
  
end
