# -*- encoding : utf-8 -*-
class AddProductAttributeDefinesColumnsForFix < ActiveRecord::Migration
  def self.up
    add_column :product_attribute_defines, :fix, :boolean, :default => true
    add_column :product_attributes, :fix, :boolean, :default => true
  end

  def self.down
    remove_column :product_attribute_defines, :fix
    remove_column :product_attributes, :fix
  end
end
