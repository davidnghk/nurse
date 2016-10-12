class AddAttachmentToOrder < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.attachment :photo_02
      t.attachment :photo_03
      t.attachment :photo_04
      t.attachment :photo_05
      t.attachment :document_01
      t.attachment :document_02
      t.attachment :document_03
      t.attachment :document_04
      t.attachment :document_05
    end
  end

  def self.down
    remove_attachment :orders, :photo_02
    remove_attachment :orders, :photo_03
    remove_attachment :orders, :photo_04
    remove_attachment :orders, :photo_05
    remove_attachment :orders, :document_01
    remove_attachment :orders, :document_02
    remove_attachment :orders, :document_03
    remove_attachment :orders, :document_04
    remove_attachment :orders, :document_05
  end
end
