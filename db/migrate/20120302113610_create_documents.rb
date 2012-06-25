# -*- encoding : utf-8 -*-
class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :transaction_id
      t.string :doc

      t.timestamps
    end
  end
end
