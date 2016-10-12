class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.references :client, index: true, foreign_key: true
      t.string :code
      t.string :name
      t.string :chi_name
      t.string :address
      t.string :chi_address
      t.references :district, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
