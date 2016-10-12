class ChangeCalldateToOrders < ActiveRecord::Migration
  def change
    change_column :orders, :call_date,  :datetime
  end
end
