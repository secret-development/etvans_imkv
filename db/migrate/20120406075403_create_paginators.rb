# -*- encoding : utf-8 -*-
class CreatePaginators < ActiveRecord::Migration
  def change
    create_table :paginators do |t|
      t.string :resource
      t.integer :paginate
    end
  end
end
