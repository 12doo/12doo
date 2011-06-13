# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index  
    

    params[:keywords] = '干红'
    sku = []
    sku = ProductAttribute.select("distinct(product_sku)").where("value like :keywords", :keywords => "%#{params[:keywords]}%")
    skus = []
    sku.each do |item|
      skus << item.product_sku
    end
    
    #@products = Product.where(:sku => skus, :visiable => true).order('id desc').page(params[:page])
    @list = Product.where("(sku in (:skus) ) and visiable = :visiable", :skus => skus, :visiable => true).order('id desc')

    @red1=@list[1]
    @red2=@list[3]
    @red3=@list[4]
    @red4=@list[2]
  
    @promo1=Product.find(5)
    @promo2=Product.find(11)
    @promo3=Product.find(10)
    @promo4=Product.find(1)
    
    params[:keywords] = '干白'
    sku = []
    sku = ProductAttribute.select("distinct(product_sku)").where("value like :keywords", :keywords => "%#{params[:keywords]}%")
    skus = []
    sku.each do |item|
      skus << item.product_sku
    end
    
    #@products = Product.where(:sku => skus, :visiable => true).order('id desc').page(params[:page])
    @list = Product.where("(sku in (:skus) ) and visiable = :visiable", :skus => skus, :visiable => true).order('id desc')
    
    @white1=@list[1]
    @white2=@list[3]
    @white3=@list[4]
    @white4=@list[2]
    
    @other1=Product.find(9)
    @other2=Product.find(1)
    @other3=Product.find(10)
    @other4=Product.find(5)
   
  end
end
