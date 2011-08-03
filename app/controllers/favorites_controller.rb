# -*- encoding : utf-8 -*-
class FavoritesController < ApplicationController

  # 身份验证
  before_filter :authorize_user!
  before_filter :authorize_admin!, :only => [:index]
  
  def index
    @items = Favorites.order("id")
  end
  
  def add_product
    if params[:id]
      product = Product.find(params[:id])
      if Favorite.add_product(product, current_user)
        respond_to do |format| 
          format.json { render :json => product.id }
        end
      else
        respond_to do |format| 
          format.json { render :json => nil }
        end
      end
    end

  end
  
  def delete_product
    if params[:id]
      product = Product.find(params[:id])
      if Favorite.delete_product(product, current_user)
        respond_to do |format| 
          format.json { render :json => product.id } 
        end
      else
        respond_to do |format| 
          format.json { render :json => nil } 
        end
      end
    end
  end

end
