# -*- encoding : utf-8 -*-
class CreateRcustomers < ActiveRecord::Migration
  def change
    create_table :rcustomers do |t|
      t.string :firstname
      t.string :lastname
      t.string :phonehome
      t.string :phonemobile
      t.string :email
      t.text :typecust
      t.text :note

      t.timestamps
    end
  end
end
