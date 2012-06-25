# -*- encoding : utf-8 -*-
class AddPhonemobileAndPhonehomeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phonemobile, :string
    add_column :users, :phonehome, :string
  end
end
