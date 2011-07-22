class FeedsController < ApplicationController
  
  layout "application", :except => [:index]
  
  def index
    @products = Product.order("id desc").limit(50)
  end

end
