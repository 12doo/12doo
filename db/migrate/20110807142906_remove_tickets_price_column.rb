# -*- encoding : utf-8 -*-
class RemoveTicketsPriceColumn < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :price
  end

  def self.down
    add_column :tickets, :price, :precision => 10, :scale => 2, :default => 0
  end
end
