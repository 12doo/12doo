# -*- encoding : utf-8 -*-
class ProductsController < ApplicationController

  # 身份验证  
  before_filter :authorize_admin!, :except => [:query_result, :show, :promotion]
  
  def index
    @products = Product.order("id desc").page(params[:page])
  end
  
  def promotion
    @products = Product.where("promo = :promo and visiable = :visiable", :promo => true, :visiable => true).order('id desc').page(params[:page]).per(9)
  end
  
  def query_result
    sort_by = "id"
    sort = "desc"
    if params[:sort] && params[:sort] == "0"
      sort = "asc"
    end
    
    if params[:sort_by]
      sort_by = params[:sort_by].gsub(/\s/, '')
    end
    
    if (params[:tags] == nil || condition_is_null) && (params[:keywords] == nil || params[:keywords] == '')
      @products = Product.where(:visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(9)
    else
      sku = []
      if (params[:tags] == nil || condition_is_null) && params[:keywords] && params[:keywords] != ''
        # 如果tag为空,keywords不为空
        sku = ProductAttribute.select("distinct(product_sku)").where("value like :keywords", :keywords => "%#{params[:keywords]}%")
      elsif params[:keywords] == nil && params[:tags] && params[:tags] != '' && !condition_is_null
        # 如果keywords为空,tags不为空
        sku = ProductAttribute.select("product_sku").where("product_attribute_value_id in (:skus)", :skus => params[:tags].split(/,|-/).delete_if{|item| item == "0"}).group("product_sku").having("count(*) > #{effective_section_count}")
      else
        # 如果都不为空
        sku = ProductAttribute.select("product_sku").where("(product_attribute_value_id in (:skus)) or value like :keywords",:skus => params[:tags].split(/,|-/).delete_if{|item| item == "0"}, :keywords => "%#{params[:keywords]}%").group("product_sku").having("count(*) > #{effective_section_count}")
      end
      
      skus = []
      sku.each do |item|
        skus << item.product_sku
      end
      
      if params[:keywords] && params[:keywords] != ''
        if condition_is_null
          @products = Product.where("(sku in (:skus) or cn_name like :cn_name or name like :name) and visiable = :visiable", :skus => skus, :cn_name => "%#{params[:keywords]}%", :name => "%#{params[:keywords]}%", :visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(9)
        else
          @products = Product.where("(sku in (:skus) and (cn_name like :cn_name or name like :name)) and visiable = :visiable", :skus => skus, :cn_name => "%#{params[:keywords]}%", :name => "%#{params[:keywords]}%", :visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(9)
        end
      else
        @products = Product.where("sku in (:skus) and visiable = :visiable", :skus => skus, :visiable => true).order("#{sort_by} #{sort}").page(params[:page]).per(9)
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    if @product
      @title = @product.cn_name
      unless @product.visiable
        redirect_to :action => "index"
      else
        respond_to do |format|
          if @product.template_name != ''
            format.html { render "products/templates/common" }
          else
            format.html { render :action => "show" }
          end

        end
      end
    end
  end
  
  def preview
    @product = Product.find(params[:id])
    if @product
      @title = @product.cn_name
      respond_to do |format|
        if @product.template_name != ''
          format.html { render "products/templates/common" }
        else
          format.html { render :action => "show" }
        end
      end
    end
  end

  def new
    @product = Product.new
    @statuses = ProductStatus.all
    @years = (Time.now.year).downto(Time.now.year - 30).map{ |x| x }
    @attributes = ProductAttributeDefine.all
  end
  
  def create
    @product = Product.new(params[:product])
    
    if params[:product_attributes]
      params[:product_attributes].each do |short|
        if params["product_attribute_" + short] && params["product_attribute_" + short] != ''
          params["product_attribute_" + short].each do |value|
            @product.add_attribute(short,value)
          end
        end
      end
    end
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to :action => "index" }
      else
        @statuses = ProductStatus.all
        @years = (Time.now.year).downto(Time.now.year - 30).map{ |x| x }
        @attributes = ProductAttributeDefine.all
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
    @statuses = ProductStatus.all
    @years = (Time.now.year).downto(Time.now.year - 30).map{ |x| x }
    @attributes = ProductAttributeDefine.all
  end

  def update
    @product = Product.find(params[:id])
    
    if params[:product_attributes]
      params[:product_attributes].each do |short|
        if params["product_attribute_" + short] && params["product_attribute_" + short] != ''
            @product.set_attributes(short,params["product_attribute_" + short])
        end
      end
    end

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to products_path }
      else
        @statuses = ProductStatus.all
        @years = (Time.now.year).downto(Time.now.year - 30).map{ |x| x }
        @attributes = ProductAttributeDefine.all
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to :action => :index, :controller => :products  }
      format.xml  { head :ok }
    end
  end
  
  def delete_tag
    @product = Product.find(params[:id])
    tag = @product.product_tags.find(:first,:conditions => {:key => params[:key]})
    if tag
      tag.destroy
    end
    
    redirect_to :action => 'edit',:id=>params[:id]
  end
  
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
