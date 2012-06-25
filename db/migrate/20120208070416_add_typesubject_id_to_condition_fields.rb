# -*- encoding : utf-8 -*-
class AddTypesubjectIdToConditionFields < ActiveRecord::Migration
  def change
    add_column :condition_fields, :typesubject_id, :integer
  end
end
