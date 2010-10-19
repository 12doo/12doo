class RenameOrdersColumnCountToQuantity < ActiveRecord::Migration
  def self.up
    rename_column :orders, :count, :quantity
  end

  def self.down
    rename_column :orders, :quantity, :count
  end
end
