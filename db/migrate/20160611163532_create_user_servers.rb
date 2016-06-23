class CreateUserServers < ActiveRecord::Migration
  def change
    create_table :user_servers do |t|
      t.string :profession_status

      t.timestamps null: false
    end
  end
end
