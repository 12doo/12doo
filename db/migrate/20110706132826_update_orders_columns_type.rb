class UpdateOrdersColumnsType < ActiveRecord::Migration
  def self.up
    change_column :orders, :total, :decimal, :precision => 10, :scale => 2
    change_column :orders, :carriage, :decimal, :precision => 10, :scale => 2
    change_column :orders, :discount, :decimal, :precision => 10, :scale => 2
    change_column :orders, :pay_price, :decimal, :precision => 10, :scale => 2
    change_column :orders, :coupon_discount, :decimal, :precision => 10, :scale => 2
    change_column :orders, :discount_rate, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    change_column :orders, :total, :decimal, :precision => 10, :scale => 0
    change_column :orders, :carriage, :decimal, :precision => 10, :scale => 0
    change_column :orders, :discount, :decimal, :precision => 10, :scale => 0
    change_column :orders, :pay_price, :decimal, :precision => 10, :scale => 0
    change_column :orders, :coupon_discount, :decimal, :precision => 10, :scale => 0
    change_column :orders, :discount_rate, :decimal, :precision => 10, :scale => 0
  end
end
