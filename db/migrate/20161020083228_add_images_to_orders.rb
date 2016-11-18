class AddImagesToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :image_03, :string
    add_column :orders, :image_04, :string
  end
end
