# -*- encoding : utf-8 -*-
require 'spec_helper'

describe PaginatorsController do
  render_views
  
  before(:each) do
    # start auth
    @user = Factory(:user)
    test_log_in(@user)
    # end auth
    
    @paginator = Factory(:paginator)
  end
  
  it "get index" do
    get :index
    response.should be_success
  end
  
  it "get edit" do
    get :edit, :id => @paginator
    response.should be_success
  end
  
  describe "update" do
    describe "failure" do
      before(:each) do
        @attr = invalid_data
      end
      
      it "should render the edit page" do
        put :update, :id => @paginator, :paginator => @attr
        response.should render_template('edit')
      end
      
      it "should not create a paginator" do
        lambda do
          put :update, :id => @paginator, :paginator => @attr
        end.should_not change(Paginator, :count)
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = valid_data
      end
      
      it "should redirect to list paginators page" do
        put :update, :id => @paginator, :paginator => @attr
        response.should redirect_to(paginators_path)
      end
      
      it "should not create a paginator" do
        lambda do
          put :update, :id => @paginator, :paginator => @attr  
        end.should_not change(Paginator, :count)
      end
      
      it "should have success message" do
        put :update, :id => @paginator, :paginator => @attr
        flash[:notice].should =~ /Постраничный вывод успешно обновлен/i
      end
      
    end
  end
  
  def invalid_data
    {
      :paginate => 0
    }
  end
  
  def valid_data
    {
      :paginate => 10
    }
  end

end
