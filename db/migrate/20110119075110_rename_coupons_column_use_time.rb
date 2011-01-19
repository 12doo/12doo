class RenameCouponsColumnUseTime < ActiveRecord::Migration
  def self.up
    rename_column :coupons, :use_time, :used_time
  end

  def self.down
    rename_column :coupons, :used_time, :use_time
  end
end
