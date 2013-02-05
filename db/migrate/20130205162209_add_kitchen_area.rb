class AddKitchenArea < ActiveRecord::Migration
  def change
    add_column :subjects, :kitchen_area, :float
  end
end
