class AddPayPriceColumnToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :pay_price, :decimal
  end

  def self.down
    remove_column :orders, :pay_price
  end
end
