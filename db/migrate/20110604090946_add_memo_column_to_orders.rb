class AddMemoColumnToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :memo, :string, :default => ''
  end

  def self.down
    add_column :orders, :memo
  end
end
