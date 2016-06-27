class AddPaymentToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :payment, :integer, default: 0
  end
end
