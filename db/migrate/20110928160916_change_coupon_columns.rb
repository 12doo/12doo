# -*- encoding : utf-8 -*-
class ChangeCouponColumns < ActiveRecord::Migration
  def self.up
    remove_column :coupons, :all_user
    rename_column :coupons, :product_category, :category_id
    change_column :coupons, :category_id, :integer
  end

  def self.down
    add_column :coupons, :all_user, :boolean, :default => 1
    rename_column :coupons, :category_id, :product_category
    change_column :coupons, :product_category, :string
  end
end
