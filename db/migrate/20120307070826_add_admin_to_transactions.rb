# -*- encoding : utf-8 -*-
class AddAdminToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :admin, :boolean
  end
end
