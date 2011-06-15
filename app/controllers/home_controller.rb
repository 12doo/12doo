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
    
    sku = ProductAttribute.select("distinct(product_sku)").where("value like :keywords", :keywords => "%促销%")

    skus = []
    sku.each do |item|
      skus << item.product_sku
    end
    
    @promo = Product.where("(sku in (:skus) ) and visiable = :visiable", :skus => skus, :visiable => true).order('id desc').page(1).per(4)

    @other = Product.where("visiable = :visiable", :visiable => true).order('id desc').page(1).per(4)   
  end
end
