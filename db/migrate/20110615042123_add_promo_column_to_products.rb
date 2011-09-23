# -*- encoding : utf-8 -*-
class AddPromoColumnToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :promo, :boolean, :default => false
  end

  def self.down
    remove_column :products, :promo
  end
end
