class UpdateCouponsColumnBelongsToType < ActiveRecord::Migration
  def self.up
    change_column :coupons, :belongs_to, :integer
  end

  def self.down
    change_column :coupons, :belongs_to, :string
  end
end
