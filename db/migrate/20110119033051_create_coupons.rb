class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.string :code
      t.decimal :discount
      t.decimal :threshold
      t.string :product_category
      t.string :belongs_to
      t.boolean :all_user
      t.boolean :one_off
      t.datetime :begin
      t.datetime :end
      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
