class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :order_datetime
      t.integer :hours
      t.integer :hospital
      t.string :location
      t.integer :fee
      t.integer :cost
      t.string :contact_person
      t.integer :contact_phone_no
      t.string :payment_token

      t.timestamps null: false
    end
  end
end
