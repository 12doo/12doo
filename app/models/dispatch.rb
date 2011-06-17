# -*- encoding : utf-8 -*-
class Dispatch < ActiveRecord::Base
  has_many :dispatch_items
  paginates_per 20
end
