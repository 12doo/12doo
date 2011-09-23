# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  
  def index
    @products = []
    @attributes = []
    if params[:cats]
    end
    sort_by = "id"
    sort = "desc"
    if params[:sort] && params[:sort] == "0"
      sort = "asc"
    end
  
    if params[:sort_by]
      sort_by = params[:sort_by].gsub(/\s/, '')
    end
  
    if params[:keywords] == nil || params[:keywords] == ''
      @products = Product.where(:visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(12)
    else
      sku = ProductAttribute.select("distinct(product_sku)").where("value like :keywords", :keywords => "%#{params[:keywords]}%")
      skus = []
      sku.each do |item|
        skus << item.product_sku
      end
      @products = Product.where("(sku in (:skus) or cn_name like :cn_name or name like :name) and visiable = :visiable", :skus => skus, :cn_name => "%#{params[:keywords]}%", :name => "%#{params[:keywords]}%", :visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(12)
    end
  end
  
  def category
    @products = []
    @category = Category.find(params[:cat])
    @menu = @category.short
    @attributes = []
    if params[:cat] && params[:tags]
      
      sort_by = "id"
      sort = "desc"
      if params[:sort] && params[:sort] == "0"
        sort = "asc"
      end
    
      if params[:sort_by]
        sort_by = params[:sort_by].gsub(/\s/, '')
      end
    
      if (params[:tags] == nil || condition_is_null) && (params[:keywords] == nil || params[:keywords] == '')
        @products = Product.where(:visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(12)
      else
        id = []
        if (params[:tags] == nil || condition_is_null) && params[:keywords] && params[:keywords] != ''
          # 如果tag为空,keywords不为空
          id = ProductAttribute.select("distinct(product_id)").where("value like :keywords", :keywords => "%#{params[:keywords]}%")
        elsif params[:keywords] == nil && params[:tags] && params[:tags] != '' && !condition_is_null
          # 如果keywords为空,tags不为空
          id = ProductAttribute.select("product_id").where("product_attribute_value_id in (:ids)", :ids => params[:tags].split(/,|-/).delete_if{|item| item == "0"}).group("product_id").having("count(*) > #{effective_section_count}")
        else
          # 如果都不为空
          id = ProductAttribute.select("product_id").where("(product_attribute_value_id in (:ids)) or value like :keywords",:ids => params[:tags].split(/,|-/).delete_if{|item| item == "0"}, :keywords => "%#{params[:keywords]}%").group("product_id").having("count(*) > #{effective_section_count}")
        end
      
        ids = []
        id.each do |item|
          ids << item.product_id
        end
      
        if params[:keywords] && params[:keywords] != ''
          if condition_is_null
            @products = Product.where("(id in (:ids) or cn_name like :cn_name or name like :name) and visiable = :visiable", :ids => ids, :cn_name => "%#{params[:keywords]}%", :name => "%#{params[:keywords]}%", :visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(12)
          else
            @products = Product.where("(id in (:ids) and (cn_name like :cn_name or name like :name)) and visiable = :visiable", :ids => ids, :cn_name => "%#{params[:keywords]}%", :name => "%#{params[:keywords]}%", :visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(12)
          end
        else
          @products = Product.where("id in (:ids) and visiable = :visiable", :ids => ids, :visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(12)
        end
      end
    else
      redirect_to "/search?keywords=#{params[:keywords]}"
    end
  end

  protected
  
  def condition_is_null
    params[:tags].split('-').each_with_index do |item, index|
      if item && item != '' && item != "0"
        return false
      end
    end
    return true
  end
  
  def effective_section_count
    flag = -1
    params[:tags].split('-').each do |item|
      if item && item != '' && item != "0"
          flag = flag + 1
      end
    end
    flag
  end
end
