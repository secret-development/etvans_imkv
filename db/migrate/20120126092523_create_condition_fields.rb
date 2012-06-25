# -*- encoding : utf-8 -*-
class CreateConditionFields < ActiveRecord::Migration
  def change
    create_table :condition_fields do |t|
      t.string :namefield
      t.timestamps
    end
  end
end
