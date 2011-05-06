# -*- encoding : utf-8 -*-
class AddAddressToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :fullname, :string
    add_column :orders, :address, :string
    add_column :orders, :province, :string
    add_column :orders, :city, :string
    add_column :orders, :region, :string
    add_column :orders, :zip, :string
    add_column :orders, :phone, :string
  end

  def self.down
    remove_column :orders, :phone
    remove_column :orders, :zip
    remove_column :orders, :region
    remove_column :orders, :city
    remove_column :orders, :province
    remove_column :orders, :address
    remove_column :orders, :fullname
  end
end
