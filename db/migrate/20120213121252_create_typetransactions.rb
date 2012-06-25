# -*- encoding : utf-8 -*-
class CreateTypetransactions < ActiveRecord::Migration
  def change
    create_table :typetransactions do |t|
      t.string :name
      t.timestamps
    end
  end
end
