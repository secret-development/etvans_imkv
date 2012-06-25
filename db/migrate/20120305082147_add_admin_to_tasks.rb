# -*- encoding : utf-8 -*-
class AddAdminToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :admin, :boolean

  end
end
