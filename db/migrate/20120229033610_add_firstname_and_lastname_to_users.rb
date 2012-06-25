# -*- encoding : utf-8 -*-
class AddFirstnameAndLastnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
