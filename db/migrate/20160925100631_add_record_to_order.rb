class AddRecordToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :record, :string
  end
end
