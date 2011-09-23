# -*- encoding : utf-8 -*-
class CreateDispatchItems < ActiveRecord::Migration
  def self.up
    create_table :dispatch_items do |t|
      t.integer :dispatch_id
      t.integer :product_id
      t.string :product_name
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :dispatch_items
  end
end
