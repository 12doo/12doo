# -*- encoding : utf-8 -*-
class CouponUsedRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :coupon
end
