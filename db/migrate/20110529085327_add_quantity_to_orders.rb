class AddQuantityToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :quantity, :decimal, :default => 0
  end

  def self.down
    remove_column :orders, :quantity
  end
end
