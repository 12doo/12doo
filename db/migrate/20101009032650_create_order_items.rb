# -*- encoding : utf-8 -*-
class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.string :order_no
      t.integer :quantity
      t.decimal :price
      t.decimal :subtotal
      t.string :product_name
      t.string :product_sku
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :order_items
  end
end
