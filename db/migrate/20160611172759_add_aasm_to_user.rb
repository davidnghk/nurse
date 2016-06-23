class AddAasmToUser < ActiveRecord::Migration
  def up
    rename_column :users, :status, :aasm_state
    add_column :users, :status, :integer
  end

  def down  
    rename_column :users, :aasm_state, :status
    drop_column :users, :status
  end
end
