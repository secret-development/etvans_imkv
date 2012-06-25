# -*- encoding : utf-8 -*-
class AddSrcAddressToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :street_src, :string
    add_column :subjects, :house_src, :string
    add_column :subjects, :flat_src, :string
  end
end
