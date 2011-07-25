class Ticket < ActiveRecord::Base
  belongs_to :product
  paginates_per 10
  
  def self.new_code(prefix)
    chars = ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(10) { |i| newpass << chars[rand(chars.size-1)] }
    
    # 查看重复
    if Ticket.find_by_code(prefix + newpass)
      self.new_code
    else
      prefix + newpass
    end
  end
end
