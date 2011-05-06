# -*- encoding : utf-8 -*-
class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.integer :area_id
      t.decimal :door_step
      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
