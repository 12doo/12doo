class AddProductsColumnsForDiscount < ActiveRecord::Migration
  def self.up
    add_column :products, :promo_price, :decimal, :precision => 10, :scale => 2
    change_column :products, :price, :decimal, :precision => 10, :scale => 2
    change_column :products, :indication_price, :decimal, :precision => 10, :scale => 2
    
    change_column :order_items, :price, :decimal, :precision => 10, :scale => 2
    change_column :order_items, :subtotal, :decimal, :precision => 10, :scale => 2
    
    Product.update_all ["promo_price = price * 0.8"]
  end

  def self.down
    remove_column :products, :promo_price
    change_column :products, :price, :decimal, :precision => 10, :scale => 0
    change_column :products, :indication_price, :decimal, :precision => 10, :scale => 0
    
    change_column :order_items, :price, :decimal, :precision => 10, :scale => 0
    change_column :order_items, :subtotal, :decimal, :precision => 10, :scale => 0
  end
end
