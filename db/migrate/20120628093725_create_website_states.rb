class CreateWebsiteStates < ActiveRecord::Migration
  def change
    create_table :website_states do |t|
      t.string :title
      t.text :description
      t.string :address
    end
  end
end
