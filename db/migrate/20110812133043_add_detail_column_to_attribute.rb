class AddDetailColumnToAttribute < ActiveRecord::Migration
  def self.up
    add_column :product_attribute_defines, :detail, :boolean, :default => true
  end

  def self.down
    remove_column :product_attribute_defines, :detail
  end
end
