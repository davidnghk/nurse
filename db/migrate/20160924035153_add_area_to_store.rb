class AddAreaToStore < ActiveRecord::Migration
  def change
    add_column :stores, :area, :string
    add_column :stores, :chi_area, :string
  end
end
