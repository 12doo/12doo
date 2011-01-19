class AddOrdersColumnsForDelivery < ActiveRecord::Migration
  def self.up
    add_column :orders, :delivery_type, :string
    add_column :orders, :carriage, :decimal
    add_column :orders, :coupon_code, :string
    add_column :orders, :discount, :decimal
  end

  def self.down
    remove_column :orders, :delivery_type
    remove_column :orders, :carriage
    remove_column :orders, :coupon_code
    remove_column :orders, :discount
  end
end
