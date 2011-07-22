class FeedsController < ApplicationController
  
  layout "application", :except => [:index]
  
  def index
    @products = Product.where(:visiable => true).order("id desc").limit(50)
  end

end
