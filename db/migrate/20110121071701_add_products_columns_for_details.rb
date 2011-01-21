class AddProductsColumnsForDetails < ActiveRecord::Migration
  def self.up
    add_column :products, :cn_name, :string
    remove_column :products, :vintage
  end

  def self.down
    remove_column :products, :cn_name
    add_column :prouducts, :vintage, :integer
  end
end
