class AddAcknowledgementDatetimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :acknowledgement_datetime, :datetime
  end
end
