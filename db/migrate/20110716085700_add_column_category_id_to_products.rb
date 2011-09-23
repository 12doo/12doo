# -*- encoding : utf-8 -*-
class AddColumnCategoryIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :category_id, :integer
    add_column :products, :template_name, :string, :default => ''
  end

  def self.down
    remove_column :products, :category_id
    remove_column :products, :template_name
  end
end
