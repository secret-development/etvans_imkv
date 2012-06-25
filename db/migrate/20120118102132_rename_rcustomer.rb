# -*- encoding : utf-8 -*-
class RenameRcustomer < ActiveRecord::Migration
  def change
    rename_table :rcustomers, :customers    
  end
end
