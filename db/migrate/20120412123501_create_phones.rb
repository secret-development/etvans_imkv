# -*- encoding : utf-8 -*-
class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :customerphone
      t.integer :customer_id
    end
  end
end
