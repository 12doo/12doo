# -*- encoding : utf-8 -*-
class AddColumnsToDispatchAndItem < ActiveRecord::Migration
  def self.up
    add_column :dispatches, :order_no, :string
    add_column :dispatches, :order_total, :decimal
    add_column :dispatches, :order_carriage, :decimal
    add_column :dispatches, :order_fullname, :string
    add_column :dispatches, :order_address, :string
    add_column :dispatches, :order_province, :string
    add_column :dispatches, :order_city, :string
    add_column :dispatches, :order_region, :string
    add_column :dispatches, :order_zip, :string
    add_column :dispatches, :order_phone, :string
    add_column :dispatches, :order_delivery_type, :string
    add_column :dispatches, :order_pay_price, :decimal
    add_column :dispatches, :order_discount, :decimal
    add_column :dispatches, :order_quantity, :decimal
    add_column :dispatches, :order_memo, :string
    add_column :dispatches, :order_pay_type, :string
    
    add_column :dispatch_items, :product_price, :decimal
    add_column :dispatch_items, :subtotal, :decimal
    rename_column :dispatch_items, :count, :quantity
    
  end

  def self.down
    remove_column :dispatches, :order_no
    remove_column :dispatches, :order_total
    remove_column :dispatches, :order_carriage
    remove_column :dispatches, :order_fullname
    remove_column :dispatches, :order_address
    remove_column :dispatches, :order_province
    remove_column :dispatches, :order_city
    remove_column :dispatches, :order_region
    remove_column :dispatches, :order_zip
    remove_column :dispatches, :order_phone
    remove_column :dispatches, :order_delivery_type
    remove_column :dispatches, :order_pay_price
    remove_column :dispatches, :order_discount
    remove_column :dispatches, :order_quantity
    remove_column :dispatches, :order_memo
    remove_column :dispatches, :order_pay_type
    
    remove_column :dispatch_items, :product_price
    remove_column :dispatch_items, :subtotal
    rename_column :dispatch_items, :quantity , :count
    
  end
end
