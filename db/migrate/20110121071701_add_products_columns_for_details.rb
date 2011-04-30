# -*- encoding : utf-8 -*-
class AddProductsColumnsForDetails < ActiveRecord::Migration
  def self.up
    add_column :products, :cn_name, :string
    add_column :products, :pic, :string
    add_column :products, :sold_count, :integer
    remove_column :products, :vintage
    remove_column :products, :country
  end

  def self.down
    remove_column :products, :cn_name
    remove_column :products, :pic
    remove_column :products, :sold_count
    add_column :products, :vintage, :integer
    add_column :products, :country, :string
  end
end
