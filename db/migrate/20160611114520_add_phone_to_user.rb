class AddPhoneToUser < ActiveRecord::Migration
  def up
    add_column :users, :phone_no, :integer 
  end

  def down  
    remove_column :users, :phone_no
  end
end
