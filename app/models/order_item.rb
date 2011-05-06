# -*- encoding : utf-8 -*-
class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
end
