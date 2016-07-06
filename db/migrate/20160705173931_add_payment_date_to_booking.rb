class AddPaymentDateToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :payment_datetime, :datetime
  end
end
