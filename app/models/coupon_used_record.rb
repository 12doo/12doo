class CouponUsedRecord < ActiveRecord::Base
  belongs_to :user, :foreign_key => "id", :primary_key => "user_id"
  belongs_to :coupon, :foreign_key => "id", :primary_key => "coupon_id"
end
