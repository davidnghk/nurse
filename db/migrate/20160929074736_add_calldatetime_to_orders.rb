class AddCalldatetimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :call_datetime, :datetime
  end
end
