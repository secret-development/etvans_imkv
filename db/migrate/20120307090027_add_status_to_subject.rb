# -*- encoding : utf-8 -*-
class AddStatusToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :active, :boolean, :default => true
  end
end
