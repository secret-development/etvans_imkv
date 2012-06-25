# -*- encoding : utf-8 -*-
class AddRoomToTypesubject < ActiveRecord::Migration
  def change
    add_column :typesubjects, :room, :boolean
  end
end
