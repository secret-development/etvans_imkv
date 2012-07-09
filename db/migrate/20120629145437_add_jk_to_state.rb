class AddJkToState < ActiveRecord::Migration
  def change
    add_column :website_states, :jk, :string
  end
end