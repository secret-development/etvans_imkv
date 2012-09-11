class RenameTablesAdvicesStates < ActiveRecord::Migration
  def change
    rename_table(:website_advices, :advices)
    rename_table(:website_states, :states)
  end
end
