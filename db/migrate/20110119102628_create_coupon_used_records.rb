class CreateCouponUsedRecords < ActiveRecord::Migration
  def self.up
    create_table :coupon_used_records do |t|
      t.integer :coupon_id
      t.string :coupon_code
      t.integer :user_id
      t.datetime :use_at
      t.string :order_id
      t.string :order_no
      
      t.timestamps
    end
  end

  def self.down
    drop_table :coupon_used_records
  end
end
