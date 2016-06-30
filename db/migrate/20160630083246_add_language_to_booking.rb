class AddLanguageToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :preferred_language, :integer, default: 0
    add_column :bookings, :notes, :string
  end
end
