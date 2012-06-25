# -*- encoding : utf-8 -*-
class CreateWorktimes < ActiveRecord::Migration
  def change
    create_table :worktimes do |t|
      t.integer :start_hour
      t.integer :start_min
      t.integer :end_hour
      t.integer :end_min
    end
  end
end
