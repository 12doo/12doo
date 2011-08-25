# -*- encoding : utf-8 -*-
class CartController < ApplicationController
  
  layout "application", :except => [:in_container]

  def add_product
    cart = find_cart
    quantity = 1
    if params[:quantity]
      quantity = Integer(params[:quantity])
    end
    cart.add_product(find_product, quantity)
    respond_to do |format| 
      format.html { redirect_to :action => 'show' }
      format.json { render :json => cart.quantity } 
    end
    
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
  
  def show
  end
  
  private
  
  def find_cart
    session[:cart] ||= Cart.new
  end
  
  def find_productid
    params[:id]
  end
  
  def find_product
    Product.find(params[:id])
  end
end
