# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  
  def index
    id = ProductAttribute.select("distinct(product_id)").where("value like :keywords", :keywords => "%红葡萄酒%")

    ids = []
    id.each do |item|
      ids << item.product_id
    end
    
    @red = Product.where("(id in (:ids) ) and visiable = :visiable", :ids => ids, :visiable => true).order('id desc').page(1).per(4)
    
    id = ProductAttribute.select("distinct(product_id)").where("value like :keywords", :keywords => "%白葡萄酒%")

    ids = []
    id.each do |item|
      ids << item.product_id
    end
    
    @white = Product.where("(id in (:ids) ) and visiable = :visiable", :ids => ids, :visiable => true).order('id desc').page(1).per(4)
    
    @promo = Product.where("promo = :promo and visiable = :visiable", :promo => true, :visiable => true).order('id desc').page(1).per(4)
  end
  
  def promotion
    @products = Product.where("promo = :promo and visiable = :visiable", :promo => true, :visiable => true).order('id desc').page(params[:page]).per(16)
  end
  
  def info
  end
  
end
