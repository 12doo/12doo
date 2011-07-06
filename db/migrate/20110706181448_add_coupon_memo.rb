class AddCouponMemo < ActiveRecord::Migration
  def self.up
    add_column :coupons, :memo, :string, :default => ''
  end

  def self.down
    remove_column :coupons, :memo
  end
end
