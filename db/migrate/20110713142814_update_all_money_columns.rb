# -*- encoding : utf-8 -*-
class UpdateAllMoneyColumns < ActiveRecord::Migration
  def self.up
    change_column :alipay_logs, :price, :decimal, :precision => 10, :scale => 2
    change_column :alipay_logs, :total_fee, :decimal, :precision => 10, :scale => 2
    change_column :coupons, :discount, :decimal, :precision => 10, :scale => 2
    change_column :coupons, :threshold, :decimal, :precision => 10, :scale => 2
    change_column :deliveries, :door_step, :decimal, :precision => 10, :scale => 2
    change_column :dispatch_items, :product_price, :decimal, :precision => 10, :scale => 2
    change_column :dispatch_items, :subtotal, :decimal, :precision => 10, :scale => 2
    change_column :dispatches, :order_total, :decimal, :precision => 10, :scale => 2
    change_column :dispatches, :order_carriage, :decimal, :precision => 10, :scale => 2
    change_column :dispatches, :order_pay_price, :decimal, :precision => 10, :scale => 2
    change_column :dispatches, :order_discount, :decimal, :precision => 10, :scale => 2
    change_column :favorites, :price, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    change_column :alipay_logs, :price, :decimal, :precision => 10, :scale => 0
    change_column :alipay_logs, :total_fee, :decimal, :precision => 10, :scale => 0
    change_column :coupons, :discount, :decimal, :precision => 10, :scale => 0
    change_column :coupons, :threshold, :decimal, :precision => 10, :scale => 0
    change_column :deliveries, :door_step, :decimal, :precision => 10, :scale => 0
    change_column :dispatch_items, :product_price, :decimal, :precision => 10, :scale => 0
    change_column :dispatch_items, :subtotal, :decimal, :precision => 10, :scale => 0
    change_column :dispatches, :order_total, :decimal, :precision => 10, :scale => 0
    change_column :dispatches, :order_carriage, :decimal, :precision => 10, :scale => 0
    change_column :dispatches, :order_pay_price, :decimal, :precision => 10, :scale => 0
    change_column :dispatches, :order_discount, :decimal, :precision => 10, :scale => 0
    change_column :favorites, :price, :decimal, :precision => 10, :scale => 0
  end
end
