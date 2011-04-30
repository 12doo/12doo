# -*- encoding : utf-8 -*-
class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.integer :product_id
      t.integer :user_id
      t.decimal :price
      t.boolean :deleted, :default => false
      t.datetime :deleted_at
      t.timestamps
    end
  end

  def self.down
    drop_table :favorites
  end
end
