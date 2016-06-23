class AddBookingdatetimeToOrder < ActiveRecord::Migration
  def up
    add_column :orders, :booking_datetime, :datetime
  end

  def down  
    drop_column :orders, :booking_datetime
  end
end
