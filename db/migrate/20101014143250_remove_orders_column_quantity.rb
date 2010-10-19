class RemoveOrdersColumnQuantity < ActiveRecord::Migration
  def self.up
    remove_column :orders, :quantity
  end

  def self.down
    add_column :orders, :quantity, :string
  end
end