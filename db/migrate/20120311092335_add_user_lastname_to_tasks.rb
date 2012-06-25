# -*- encoding : utf-8 -*-
class AddUserLastnameToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :user_lastname, :string
  end
end
