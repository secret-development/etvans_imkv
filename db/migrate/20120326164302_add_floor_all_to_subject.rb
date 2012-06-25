# -*- encoding : utf-8 -*-
class AddFloorAllToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :floorall, :integer
  end
end
