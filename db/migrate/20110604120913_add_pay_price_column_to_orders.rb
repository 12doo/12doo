# -*- encoding : utf-8 -*-
class AddPayPriceColumnToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :pay_price, :decimal
    execute "UPDATE orders SET pay_price = total"
  end

  def self.down
    remove_column :orders, :pay_price
  end
end
