# -*- encoding : utf-8 -*-
class AddProductAttributeCatAttr < ActiveRecord::Migration
  def self.up
    add_column :product_attribute_defines, :category_id, :integer, :default => 0
  end

  def self.down
    remove_column :product_attribute_defines, :category_id
  end
end
