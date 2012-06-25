# -*- encoding : utf-8 -*-
require 'spec_helper'

describe DistrictsController do
  render_views
  
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    @city = Factory(:city)
    @district = Factory(:district, :city => @city)
  end
  
  it "get 'index'" do
    get :index
    response.should be_success
  end
  
  it "get 'edit'" do
    get :edit, :id => @district.id
    response.should be_success
  end
  
  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the edit page" do
        put :update, :id => @district, :district => @attr
        response.should render_template('edit')
      end
      
      it "should not create a district" do
        lambda do
          put :update, :id => @district, :district => @attr
        end.should_not change(District, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect to districts path" do
        put :update, :id => @district, :district => @attr
        response.should redirect_to(districts_path)
      end
      
      it "should not create a district" do
        lambda do
          put :update, :id => @district, :district => @attr
        end.should_not change(District, :count)
      end
      
      it "should have success message" do
        put :update, :id => @district, :district => @attr
        flash[:notice].should =~ /Район успешно обновлён/i
      end
    end
  end
  
  describe "destroy" do
    it "should redirect to districts list page" do
      delete :destroy, :id => @district
      response.should redirect_to(districts_path)
    end
    
    it "should destroy the district" do
      lambda do
        delete :destroy, :id => @district
      end.should change(District, :count).by(-1)
    end
    
    it "should have success message" do
      delete :destroy, :id => @district
      flash[:notice].should =~ /Район успешно удалён/i
    end
  end
  
  def valid_data
    {
      :city_id => @city.id,
      :title => "Орбита"
    }
  end
  
  def invalid_data
    {
      :city_id => @city.id,
      :title => nil  
    }
  end
  
end
