# -*- encoding : utf-8 -*-
class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
      t.string :title
      t.integer :city_id
    end
  end
end
