class AddProductAttributeDefinesColumnsForSearch < ActiveRecord::Migration
  def self.up
    add_column :product_attribute_defines, :sort, :integer, :default => 0
    add_column :product_attribute_defines, :search, :boolean, :default => false
    add_column :product_attributes, :product_attribute_value_id, :integer, :default => 0
    add_column :product_attributes, :multiple, :boolean, :default => false
  end

  def self.down
    remove_column :product_attribute_defines, :sort
    remove_column :product_attribute_defines, :search
    remove_column :product_attributes, :value_id
    remove_column :product_attributes, :multiple
  end
end
