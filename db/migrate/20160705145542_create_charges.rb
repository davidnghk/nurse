class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.datetime :charge_datetime
      t.references :booking, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
