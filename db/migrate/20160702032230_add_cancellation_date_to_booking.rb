class AddCancellationDateToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :cancellation_datetime, :datetime
    add_column :bookings, :refund_amount, :integer, default: 0
    add_column :bookings, :refunded, :boolean, default: false
  end
end
