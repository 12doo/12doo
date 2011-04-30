# -*- encoding : utf-8 -*-
class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :no
      t.decimal :total
      t.string :status
      t.datetime :order_at
      t.integer :count
      t.datetime :delivery_at
      t.integer :address_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
