class AddCateIdToAttrValue < ActiveRecord::Migration
  def self.up
    add_column :product_attribute_values, :category_id, :integer, :default => 0
    add_column :product_attributes, :category_id, :integer, :default => 0
  end

  def self.down
    remove_column :product_attribute_values, :category_id
    remove_column :product_attributes, :category_id
  end
end
