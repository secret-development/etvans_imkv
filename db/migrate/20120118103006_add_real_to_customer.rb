# -*- encoding : utf-8 -*-
class AddRealToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :real, :boolean, :default => false 
  end
end
