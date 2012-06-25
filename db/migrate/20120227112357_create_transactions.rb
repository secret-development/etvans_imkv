# -*- encoding : utf-8 -*-
class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.text :description
      t.integer :customer_id
      t.integer :user_id
      t.integer :typetransaction_id
      t.integer :subject_id
      t.integer :price
      t.boolean :payment

      t.timestamps
    end
  end
end
