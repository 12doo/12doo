class AddColumnsForOrderPrice < ActiveRecord::Migration
  def self.up
    add_column :orders, :order_price, :decimal, :default => 0
    add_column :orders, :coupon_discount, :decimal, :default => 0
    add_column :orders, :discount_rate, :decimal, :default => 1
  end

  def self.down
    remove_column :orders, :order_price
    remove_column :orders, :coupon_discount
    remove_column :orders, :discount_rate
  end
end
