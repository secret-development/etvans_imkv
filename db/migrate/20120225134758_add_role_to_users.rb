# -*- encoding : utf-8 -*-
class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :boolean
  end
end
