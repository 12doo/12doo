# -*- encoding : utf-8 -*-
class Favorite < ActiveRecord::Base
  
  belongs_to :product
  
  paginates_per 20
  
  def self.add_product(product, user)
    if product && product.visiable && user
      item = user.favorites.where("product_id = :product_id", :product_id => product.id)
      unless !item || item.count > 0 
        item = Favorite.new
        item.product_id = product.id
        item.user_id = user.id
        item.price = product.current_price
        item.deleted = false
        item.save
        return true
      end
    end
    return false
  end
  
  def self.delete_product(product, user)
    if product && user
      item = user.favorites.where("product_id = :product_id", :product_id => product.id).first
      if item
        item.deleted = true
        item.deleted_at = Time.now
        item.save
        return true
      end
    end
    return false
  end
  
end
