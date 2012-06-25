# -*- encoding : utf-8 -*-
class ChangeDataTypeForTaskDeadline < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.change :deadline, :datetime
    end
  end

  def down
    change_table :tasks do |t|
      t.change :deadline, :date
    end
  end
end
