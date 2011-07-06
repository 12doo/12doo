class RemoveOrderPriceColumnFormOrders < ActiveRecord::Migration
  def self.up
    remove_column :orders, :order_price
  end

  def self.down
    add_column :orders, :order_price, :decimal, :default => 0
  end
end
