class FavoritesController < ApplicationController
  before_filter :authorize_user!
  layout "application", :except => [:in_container]
  def index
    @items = Product.joins('LEFT OUTER JOIN favorites ON favorites.product_id = products.id').where("favorites.user_id" => current_user.id)
  end
  
  # TODO: 需要重构
  def in_container
    if params[:id]
      item = Favorite.find_by_product_id(params[:id])
      unless item
        product = Product.find(params[:id])
        if product && product.visiable
          item = Favorite.new
          item.product_id = product.id
          item.user_id = current_user.id
          item.price = product.price
          item.save
        end
      end
    end
    
    @items = Product.joins('LEFT OUTER JOIN favorites ON favorites.product_id = products.id').where("favorites.user_id" => current_user.id)

  end
  
  def add_product
    if params[:id]
      item = Favorite.find_by_product_id(params[:id])
      unless item
        product = Product.find(params[:id])
        if product && product.visiable
          item = Favorite.new
          item.product_id = product.id
          item.user_id = current_user.id
          item.price = product.price
          item.save
        end
      end
    end
    redirect_to :action => 'index'
  end
  
  def delete_product
    if params[:id]
      item = Favorite.find_by_product_id(params[:id])
      if item && item.user_id == current_user.id
        item.deleted = true
        item.deleted_at = Time.now
        item.save
      end
    end
    redirect_to :action => 'index'
  end
  
  def clear
    current_user.favorites.each do |item|
      item.deleted = true
      item.deleted_at = Time.now
      item.save
    end
    redirect_to :action => 'index'
  end
end