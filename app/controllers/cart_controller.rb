class CartController < ApplicationController
  
  layout "application", :except => [:in_container]

  def add_product
    cart = find_cart
    cart.add_product(find_product)
    redirect_to :action => 'show'
  end

  def update_product
    cart = find_cart
    cart.update_product(find_product,params[:quantity].to_i)
    redirect_to :action => 'show'
  end
  
  def delete_product
    cart = find_cart
    cart.delete_product(find_product)
    redirect_to :action => 'show'
  end
  
  def clear
    cart = find_cart
    cart.clear
    redirect_to :action => 'show'
  end
  
  def in_container
    if params[:id] && params[:quantity]
      cart = find_cart
      cart.add_product(find_product,params[:quantity].to_i)
    end
  end
  
  def show
  end
  
  private
  
  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def find_product
    Product.find(params[:id])
  end
end
