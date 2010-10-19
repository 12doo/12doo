class Order < ActiveRecord::Base
    has_many :order_items, :foreign_key => "order_no", :primary_key => "no"
    belongs_to :user, :foreign_key => "id", :primary_key => "user_id"
end
