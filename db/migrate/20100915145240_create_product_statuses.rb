# -*- encoding : utf-8 -*-
class CreateProductStatuses < ActiveRecord::Migration
  def self.up
    create_table :product_statuses do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :product_statuses
  end
end
