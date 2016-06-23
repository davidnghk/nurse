class AddBookingdateToOrder < ActiveRecord::Migration
  def up
    add_column :orders, :booking_date, :date
    add_column :orders, :booking_time, :time
  end

  def down  
    drop_column :orders, :booking_date
    drop_column :orders, :booking_time
  end
end
