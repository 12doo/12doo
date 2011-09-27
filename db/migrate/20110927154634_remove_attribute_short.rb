class RemoveAttributeShort < ActiveRecord::Migration
  def self.up
    remove_column :product_attribute_defines, :short
    remove_column :product_attributes, :short
    remove_column :product_attribute_values, :short
  end

  def self.down
    add_column :product_attribute_defines, :short, :string
    add_column :product_attribute_defines, :short, :string
    add_column :product_attribute_defines, :short, :string
  end
end
