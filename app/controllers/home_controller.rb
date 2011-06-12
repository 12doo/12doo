# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index  
    
    @promo1=Product.find(14)
    @promo2=Product.find(11)
    @promo3=Product.find(3)
    @promo4=Product.find(1)
    
    @red1=Product.find(2)
    @red2=Product.find(7)
    @red3=Product.find(4)
    @red4=Product.find(5)
    
    @white1=Product.find(1)
    @white2=Product.find(3)
    @white3=Product.find(3)
    @white4=Product.find(1)
    
    @other1=Product.find(11)
    @other2=Product.find(14)
    @other3=Product.find(7)
    @other4=Product.find(5)
   
  end
end
