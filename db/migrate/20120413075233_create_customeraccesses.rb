# -*- encoding : utf-8 -*-
class CreateCustomeraccesses < ActiveRecord::Migration
  def change
    create_table :customeraccesses do |t|
      t.boolean :access
    end
  end
end
