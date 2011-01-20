class AddProductsColumns < ActiveRecord::Migration
  def self.up
    add_column :products, :country, :string
    add_column :products, :visiable, :boolean, :default => false
  end

  def self.down
    remove_column :products, :country
    remove_column :products, :visiable
  end
end
