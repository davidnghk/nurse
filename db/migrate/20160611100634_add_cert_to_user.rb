class AddCertToUser < ActiveRecord::Migration
  def up
    add_column :users, :qualification, :integer
    add_column :users, :registration_no, :string
    add_column :users, :registration_chinese_name, :string
    add_column :users, :registration_english_name, :string    
    add_column :users, :registration_expiry_date, :date
    add_column :users, :aasm_state, :string
    add_attachment :users, :image
    add_attachment :users, :hkid_image
    add_attachment :users, :certificate_image     
  end

  def down  
    remove_column :users, :qualification
    remove_column :users, :registration_no
    remove_column :users, :registration_chinese_name
    remove_column :users, :registration_english_name    
    remove_column :users, :registration_expiry_date
    remove_column :users, :aasm_state, :string
    remove_attachment :users, :image
    remove_attachment :users, :hkid_image
    remove_attachment :users, :certificate_image
  end
end
