# -*- encoding : utf-8 -*-
class AddRoomToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :room, :integer
  end
end
