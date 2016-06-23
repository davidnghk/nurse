class AddRatingToUser < ActiveRecord::Migration
  def up
    add_column :users, :rating, :decimal, :precision => 10, :scale => 2, :default => 5.0
    rename_column :users, :aasm_state, :status
  end

  def down  
    remove_column :users, :rating
    rename_column :users, :status, :aasm_state
  end
end
