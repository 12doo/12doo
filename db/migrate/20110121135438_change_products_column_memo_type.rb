# -*- encoding : utf-8 -*-
class ChangeProductsColumnMemoType < ActiveRecord::Migration
  def self.up
    change_column :products, :memo, :text, :default => ""
  end

  def self.down
    change_column :products, :memo, :string, :default => nil
  end
end
