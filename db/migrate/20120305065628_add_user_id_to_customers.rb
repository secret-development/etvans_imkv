# -*- encoding : utf-8 -*-
class AddUserIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :user_id, :integer

  end
end
