class AddAttachmentRecordToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.attachment :record
    end
  end

  def self.down
    remove_attachment :orders, :record
  end
end
