# -*- encoding : utf-8 -*-
class AddPayTypeToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :pay_type, :string, :default => ''
  end

  def self.down
    remove_column :orders, :pay_type
  end
end
