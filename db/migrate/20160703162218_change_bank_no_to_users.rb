class ChangeBankNoToUsers < ActiveRecord::Migration
  def up
    change_column :users, :bank_account_no, :bigint 
  end

  def down
    change_column :users, :bank_account_no, :int
  end
end
