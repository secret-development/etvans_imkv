# -*- encoding : utf-8 -*-
class RemoveTypecustFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :typecust
  end
end
