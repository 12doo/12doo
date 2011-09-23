# -*- encoding : utf-8 -*-
class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :code
      t.integer :product_id
      t.integer :user_id
      t.datetime :used_at
      t.decimal :price, :precision => 10, :scale => 2, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
