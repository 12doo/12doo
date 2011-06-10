# -*- encoding : utf-8 -*-
class ProductAttributeDefinesController < ApplicationController
  # 身份验证
  before_filter :authorize_admin!

  def index
    @product_attribute_defines = ProductAttributeDefine.all
  end

  def show
    @product_attribute_define = ProductAttributeDefine.find(params[:id])
  end

  def new
    @product_attribute_define = ProductAttributeDefine.new
  end

  def edit
    @product_attribute_define = ProductAttributeDefine.find(params[:id])
  end

  def create
    @product_attribute_define = ProductAttributeDefine.new(params[:product_attribute_define])

    respond_to do |format|
      if @product_attribute_define.save
        @product_attribute_define.save_values params[:values]
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
        @product_attribute_define.save_values params[:values]
        format.html { redirect_to :action => :index }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # def destroy
  #   @product_attribute_define = ProductAttributeDefine.find(params[:id])
  #   @product_attribute_define.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to(product_attribute_defines_url) }
  #     format.xml  { head :ok }
  #   end
  # end
end
