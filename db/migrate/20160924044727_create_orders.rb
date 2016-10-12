class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :store, index: true, foreign_key: true
      t.date :call_date
      t.date :repair_date
      t.integer :status
      t.integer :technician_id
      t.references :device, index: true, foreign_key: true
      t.references :issue, index: true, foreign_key: true
      t.references :work, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
