class RemoveProductAttributeSku < ActiveRecord::Migration
  def self.up
    remove_column :product_attributes, :product_sku
    remove_column :product_attributes, :name
    remove_column :product_attributes, :description
    remove_column :product_attributes, :multiple
    remove_column :product_attributes, :fix
  end

  def self.down
    add_column :product_attributes, :product_sku, :string
    add_column :product_attributes, :name, :string
    add_column :product_attributes, :description, :string
    add_column :product_attributes, :multiple, :boolean, :default => 0                        
    add_column :product_attributes, :fix, :boolean, :default => 1
  end
end
