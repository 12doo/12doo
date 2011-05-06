# -*- encoding : utf-8 -*-
class RenameAllColumnsForJoin < ActiveRecord::Migration
  def self.up
    add_column :order_items, :order_id, :integer
    add_column :order_items, :user_id, :integer
    add_column :order_items, :product_id, :integer
    add_column :product_attributes, :product_id, :integer
    add_column :product_tags, :product_id, :integer
  end

  def self.down
    remove_column :order_items, :order_id
    remove_column :order_items, :user_id
    remove_column :order_items, :product_id
    remove_column :product_attributes, :product_id
    remove_column :product_tags, :product_id
  end
end
