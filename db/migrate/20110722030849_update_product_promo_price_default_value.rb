# -*- encoding : utf-8 -*-
class UpdateProductPromoPriceDefaultValue < ActiveRecord::Migration
  def self.up
    change_column :products, :promo_price, :decimal, :precision => 10, :scale => 2, :default => 0
  end

  def self.down
    change_column :products, :promo_price, :decimal, :precision => 10, :scale => 2
  end
end
