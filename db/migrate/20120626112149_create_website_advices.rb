# -*- encoding : utf-8 -*-
class CreateWebsiteAdvices < ActiveRecord::Migration
  def change
    create_table :website_advices do |t|

      t.timestamps
    end
  end
end
