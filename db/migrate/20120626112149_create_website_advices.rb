# -*- encoding : utf-8 -*-
class CreateWebsiteAdvices < ActiveRecord::Migration
  def change
    create_table :website_advices do |t|
      t.string :title
      t.text :body
      t.string :author
      t.timestamps
    end
  end
end
