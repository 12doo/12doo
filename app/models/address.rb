class Address < ActiveRecord::Base
  belongs_to :user, :foreign_key => "id", :primary_key => "user_id"
end
