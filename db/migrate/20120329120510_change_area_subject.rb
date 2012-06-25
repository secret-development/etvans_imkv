# -*- encoding : utf-8 -*-
class ChangeAreaSubject < ActiveRecord::Migration
  def change
    change_column :subjects, :area, :float
  end
end
