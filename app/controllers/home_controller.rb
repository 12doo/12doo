# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index  
    
    @promo1=Product.find(21)
    @promo2=Product.find(22)
    @promo3=Product.find(1)
    @promo4=Product.find(24)
    
    @red1=Product.find(25)
    @red2=Product.find(26)
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
