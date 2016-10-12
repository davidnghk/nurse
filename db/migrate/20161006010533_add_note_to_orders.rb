class AddNoteToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :notes, :string  
    add_column :stores, :device_01, :string  
    add_column :stores, :device_02, :string  
    add_column :stores, :device_03, :string  
    add_column :stores, :device_04, :string  
  end
end
