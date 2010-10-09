class OrderItem < ActiveRecord::Base
  belongs_to :orders, :foreign_key => "no", :primary_key => "order_no"
end
