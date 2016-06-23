class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.datetime :datetime
      t.integer :duration
      t.integer :hospital
      t.string :location
      t.integer :server_grade
      t.integer :server_id
      t.string :contact_person
      t.integer :contact_phone_no
      t.integer :fee

      t.timestamps null: false
    end
  end
end
