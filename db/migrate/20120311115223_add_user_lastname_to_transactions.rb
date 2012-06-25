# -*- encoding : utf-8 -*-
class AddUserLastnameToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :user_lastname, :string
  end
end
