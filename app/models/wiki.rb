# -*- encoding : utf-8 -*-
class Wiki < ActiveRecord::Base
  paginates_per 20
  validates_presence_of :class, :title, :content
end
