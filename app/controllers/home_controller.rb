# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index  
    params[:id] = 1
    @product = Product.find(params[:id])
  end
end
