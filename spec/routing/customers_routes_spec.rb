# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "routes the customers controller" do
  it "routes a named route" do
    {:get => new_customer_path}.should route_to(:controller => "customers", :action => "new")    
  end
  
end

 
