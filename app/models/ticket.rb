# -*- encoding : utf-8 -*-
class Ticket < ActiveRecord::Base
  
  validates_presence_of :code, :product_id
  validates_numericality_of :product_id
  validates_uniqueness_of :code
  
  belongs_to :product
  belongs_to :exchange
  
  paginates_per 20
  
  def self.new_code(prefix,length)
    chars = "2346789CDFGHJKMPQRTVWXY".split('')
    newpass = ""
    1.upto((length && length > 0) ? length : 10) { |i| newpass << chars[rand(chars.size-1)] }
    
    # 查看重复
    if Coupon.find_by_code(prefix + newpass)
      self.new_code
    else
      prefix + newpass
    end
  end
end
