class AddCouponsColumns < ActiveRecord::Migration
  def self.up
    add_column :coupons, :use_time, :integer, :default => 0
  end

  def self.down
    remove_column :coupons, :use_time
  end
end
