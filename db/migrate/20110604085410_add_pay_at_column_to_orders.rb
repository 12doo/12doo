# -*- encoding : utf-8 -*-
class AddPayAtColumnToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :pay_at, :datetime
  end

  def self.down
    remove_column :orders, :pay_at
  end
end
