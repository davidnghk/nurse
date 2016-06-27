class AddNurseToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :nurse_id, :integer
  end
end
