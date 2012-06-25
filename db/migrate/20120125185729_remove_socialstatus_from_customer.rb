# -*- encoding : utf-8 -*-
class RemoveSocialstatusFromCustomer < ActiveRecord::Migration
  def change
    remove_column :customers, :socialstatus 
  end
end
