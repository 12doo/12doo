# -*- encoding : utf-8 -*-
class ProductAttributeDefinesController < ApplicationController
  # 身份验证
  before_filter :authorize_admin!

  def index
    @product_attribute_defines = ProductAttributeDefine.order("id desc").page(params[:page])
  end

  def show
    @product_attribute_define = ProductAttributeDefine.find(params[:id])
  end

  def new
    @categories = Category.all
    @product_attribute_define = ProductAttributeDefine.new
  end

  def edit
    @categories = Category.all
    @product_attribute_define = ProductAttributeDefine.find(params[:id])
  end

  def create
    @product_attribute_define = ProductAttributeDefine.new(params[:product_attribute_define])

    respond_to do |format|
      if @product_attribute_define.save
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @product_attribute_define = ProductAttributeDefine.find(params[:id])

    respond_to do |format|
      if @product_attribute_define.update_attributes(params[:product_attribute_define])
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
