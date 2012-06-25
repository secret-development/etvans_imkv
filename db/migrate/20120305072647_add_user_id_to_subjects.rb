# -*- encoding : utf-8 -*-
class AddUserIdToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :user_id, :integer

  end
end
