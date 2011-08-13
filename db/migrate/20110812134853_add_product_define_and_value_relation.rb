class AddProductDefineAndValueRelation < ActiveRecord::Migration
  def self.up
    add_column :product_attribute_values, :product_attribute_define_id, :integer, :default => 0
    add_column :product_attributes, :product_attribute_define_id, :integer, :default => 0
  end

  def self.down
    remove_column :product_attribute_values, :product_attribute_define_id
    remove_column :product_attributes, :product_attribute_define_id
  end
end
