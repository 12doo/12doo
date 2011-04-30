# -*- encoding : utf-8 -*-
class CreateProductTags < ActiveRecord::Migration
  def self.up
    create_table :product_tags do |t|
      t.string :product_sku
      t.string :key
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :product_tags
  end
end
