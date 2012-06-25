# -*- encoding : utf-8 -*-
class CreateValueFields < ActiveRecord::Migration
  def change
    create_table :value_fields do |t|
      t.string :valuefield
      t.integer :condition_field_id
      t.timestamps
    end
  end
end
