# -*- encoding : utf-8 -*-
class CreateTypesubjects < ActiveRecord::Migration
  def change
    create_table :typesubjects do |t|
      t.string :name
      t.string :permalink
      t.timestamps
    end
  end
end
