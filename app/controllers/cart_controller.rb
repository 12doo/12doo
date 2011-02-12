class CartController < ApplicationController
  def add_product
    cart = find
    cart.add_product(find_product)
    redirect_to :action => 'show'
  end

  def update_product
    cart = find
    cart.update_product(find_product,params[:quantity].to_i)
    redirect_to :action => 'show'
  end
  
  def delete_product
    cart = find
    cart.delete_product(find_product)
    redirect_to :action => 'show'
  end
  
  def clear
    cart = find
    cart.clear
    redirect_to :action => 'show'
  end
  
  def show
    cart = find
  end
  
  private 
  def find
    session[:cart] ||= Cart.new
  end
  def find_product
    Product.find(params[:id])
  end
end
