# -*- encoding : utf-8 -*-
class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.integer :city_id
      t.string :title
      t.timestamps
    end
    add_index :districts, :title
  end
end
