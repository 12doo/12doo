class Order < ActiveRecord::Base
    has_many :order_items, :foreign_key => "order_no", :primary_key => "no"
end
