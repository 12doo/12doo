# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base
    has_many :order_items
    belongs_to :user
    cattr_reader :per_page
    paginates_per 10
end
