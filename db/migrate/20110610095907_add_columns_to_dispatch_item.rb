# -*- encoding : utf-8 -*-
class AddColumnsToDispatchItem < ActiveRecord::Migration
  def self.up
    add_column :dispatch_items, :product_sku, :string
  end

  def self.down
    remove_column :dispatch_items, :product_sku
  end
end
