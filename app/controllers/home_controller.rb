# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index  
    
    @promo1=Product.find(5)
    @promo2=Product.find(1)
    @promo3=Product.find(12)
    @promo4=Product.find(8)
    
    @red1=Product.find(5)
    @red2=Product.find(8)
    @red3=Product.find(27)
    @red4=Product.find(28)
    
    @white1=Product.find(29)
    @white2=Product.find(1)
    @white3=Product.find(11)
    @white4=Product.find(12)
    
    @other1=Product.find(1)
    @other2=Product.find(10)
    @other3=Product.find(13)
    @other4=Product.find(15)
   
  end
end
