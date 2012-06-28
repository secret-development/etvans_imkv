class CreateWebsiteStates < ActiveRecord::Migration
  def change
    create_table :website_states do |t|

      t.timestamps
    end
  end
end
