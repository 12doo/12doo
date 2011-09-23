# -*- encoding : utf-8 -*-
class RenameCouponBelongsToColumn < ActiveRecord::Migration
  def self.up
    rename_column :coupons, :belongs_to, :user_id
  end

  def self.down
    rename_column :coupons,  :user_id, :belongs_to
  end
end
