class AddImageToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :image_01, :string
    add_column :orders, :image_02, :string
  end
end
