# -*- encoding : utf-8 -*-
class CreateSocialStatuses < ActiveRecord::Migration
  def change
    create_table :social_statuses do |t|
      t.string :title

      t.timestamps
    end
  end
end
