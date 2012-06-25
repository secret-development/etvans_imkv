# -*- encoding : utf-8 -*-
class AddDistrictToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :district_id, :integer
  end
end
