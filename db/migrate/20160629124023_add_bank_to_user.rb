class AddBankToUser < ActiveRecord::Migration
  def change
    add_column :users, :bank, :integer
    add_column :users, :bank_account_no, :integer
    add_column :users, :bank_account_name, :string
  end
end
