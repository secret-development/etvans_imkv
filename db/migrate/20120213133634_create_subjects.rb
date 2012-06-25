# -*- encoding : utf-8 -*-
class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.references :typesubject
      t.references :city
      t.integer :price
      t.integer :area
      t.string :address
      t.timestamps
    end
  end
end
