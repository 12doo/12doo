class StoreController < ApplicationController
  def index
  end

  def add_to_cart 
    @cart = find_cart
    @cart.add_product(find_product)
    redirect_to :action => 'show_cart'
  end
  
  def update_from_cart
    @cart = find_cart
    @cart.update_product(find_product,params[:quantity].to_i)
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
  
  def search
    @products = Product.joins(:product_tags).where("product_tags.value like '%#{params[:key]}%'").uniq

    respond_to do |format|
      format.html { render "products/index" }
      format.xml  { render :xml => @products }
    end
  end
  
  private 
  def find_cart 
    session[:cart] ||= Cart.new 
  end
  def find_product
    Product.find(params[:id])
  end
end
