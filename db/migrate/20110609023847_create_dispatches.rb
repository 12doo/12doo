# -*- encoding : utf-8 -*-
class CreateDispatches < ActiveRecord::Migration
  def self.up
    create_table :dispatches do |t|
      t.string :no

      t.timestamps
    end
  end

  def self.down
    drop_table :dispatches
  end
end
