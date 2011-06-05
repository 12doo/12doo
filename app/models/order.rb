# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base
    has_many :order_items
    belongs_to :user
    paginates_per 20
end
