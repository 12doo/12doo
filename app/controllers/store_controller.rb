class StoreController < ApplicationController
  def index
  end

  def add_to_cart 
    @cart = find_cart
    @cart.add_product(find_product)
    redirect_to :action => 'show_cart'
  end
  
  def remove_from_cart
    @cart = find_cart
    @cart.remove_product(find_product)
    redirect_to :action => 'show_cart'
  end
  
  def delete_from_cart
    @cart = find_cart
    @cart.delete_product(find_product)
    redirect_to :action => 'show_cart'
  end
  
  def clear_cart
    @cart = find_cart
    @cart.clear
    redirect_to :action => 'show_cart'
  end
  
  def show_cart
    @cart = find_cart
  end
  
  private 
  def find_cart 
    session[:cart] ||= Cart.new 
  end
  def find_product
    Product.find(params[:id])
  end
end
