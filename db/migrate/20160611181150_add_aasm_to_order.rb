class AddAasmToOrder < ActiveRecord::Migration
  def up
    add_column :orders, :aasm_state, :string
  end

  def down  
    drop_column :orders, :aasm_state
  end
end
