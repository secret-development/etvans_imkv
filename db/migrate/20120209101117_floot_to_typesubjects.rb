# -*- encoding : utf-8 -*-
class FlootToTypesubjects < ActiveRecord::Migration
  def change
    add_column :typesubjects, :floor, :boolean
  end
end
