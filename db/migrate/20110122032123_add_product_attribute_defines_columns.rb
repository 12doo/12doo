# -*- encoding : utf-8 -*-
class AddProductAttributeDefinesColumns < ActiveRecord::Migration
  def self.up
    add_column :product_attribute_defines, :multiple, :boolean, :default => false
  end

  def self.down
    remove_column :product_attribute_defines, :multiple
  end
end
