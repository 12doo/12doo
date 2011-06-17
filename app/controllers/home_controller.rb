# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  
  def index
    sku = ProductAttribute.select("distinct(product_sku)").where("value like :keywords", :keywords => "%干红%")

    skus = []
    sku.each do |item|
      skus << item.product_sku
    end
    
    @red = Product.where("(sku in (:skus) ) and visiable = :visiable", :skus => skus, :visiable => true).order('id desc').page(1).per(4)
    
    sku = ProductAttribute.select("distinct(product_sku)").where("value like :keywords", :keywords => "%干白%")

    skus = []
    sku.each do |item|
      skus << item.product_sku
    end
    
    @white = Product.where("(sku in (:skus) ) and visiable = :visiable", :skus => skus, :visiable => true).order('id desc').page(1).per(4)
    
    @promo = Product.where("promo = :promo and visiable = :visiable", :promo => true, :visiable => true).order('id desc').page(1).per(4)
  end
  
  def promotion
    @products = Product.where("promo = :promo and visiable = :visiable", :promo => true, :visiable => true).order('id desc').page(params[:page]).per(16)
  end
  
end
