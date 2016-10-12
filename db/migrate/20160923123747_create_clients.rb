class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :code
      t.string :name
      t.string :chi_name

      t.timestamps null: false
    end
  end
end
