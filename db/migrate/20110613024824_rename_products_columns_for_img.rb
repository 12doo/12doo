class RenameProductsColumnsForImg < ActiveRecord::Migration
  def self.up
    remove_column :products, :pic
  end

  def self.down
    add_column :products, :pic, :string
  end
end
