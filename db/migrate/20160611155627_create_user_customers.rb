class CreateUserCustomers < ActiveRecord::Migration
  def change
    create_table :user_customers do |t|

      t.timestamps null: false
    end
  end
end
