class AddPhoneToStore < ActiveRecord::Migration
  def change
    add_column :stores, :phone_no, :integer
    add_column :stores, :contact, :string
    add_column :stores, :chi_contact, :string
  end
end
