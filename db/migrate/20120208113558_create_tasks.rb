# -*- encoding : utf-8 -*-
class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.date :deadline
      t.boolean :done

      t.timestamps
    end
  end
end
