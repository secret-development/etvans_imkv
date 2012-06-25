# -*- encoding : utf-8 -*-
class AddFloorToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :floor, :integer
  end
end
