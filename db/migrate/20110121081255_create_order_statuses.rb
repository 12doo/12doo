# -*- encoding : utf-8 -*-
class CreateOrderStatuses < ActiveRecord::Migration
  def self.up
    create_table :order_statuses do |t|
      t.string :short
      t.string :display
      t.string :memo

      t.timestamps
    end
  end

  def self.down
    drop_table :order_statuses
  end
end
