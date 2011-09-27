# -*- encoding : utf-8 -*-
class ProductsController < ApplicationController

  # 身份验证  
  before_filter :authorize_admin!, :except => [:query_result, :show, :promotion]
  
  def index
    @products = Product.order("id desc").page(params[:page])
  end
  
  def promotion
    @menu = "wine"
    @products = Product.where("promo = :promo and visiable = :visiable", :promo => true, :visiable => true).order('id desc').page(params[:page]).per(12)
  end
  
  def query_result

  end

  def show
    
    @product = Product.find(params[:id])
    @menu = @product.category.short
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
    @menu = "wine"
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
    if params[:cat]
      @product = Product.new
      @product.category_id = params[:cat]
      @statuses = ProductStatus.all
      @years = (Time.now.year).downto(Time.now.year - 30).map{ |x| x }
      @categories = Category.all
      @attributes = Category.find(params[:cat]).product_attribute_defines
    else
      category = Category.find_by_short('wine')
      redirect_to new_product_path :cat => category.id
    end
  end
  
  def create
    @product = Product.new(params[:product])
    @categories = Category.all
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
    @categories = Category.all
    
    if params[:cat]
      @product.category_id = params[:cat]
    end
    @attributes = Category.find(@product.category_id).product_attribute_defines
    
  end

  def update
    @product = Product.find(params[:id])
    @categories = Category.all
    
    unless @product.category_id == params[:product][:category_id]
      @product.change_category
    end
    
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
  
end
