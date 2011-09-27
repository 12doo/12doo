# -*- encoding : utf-8 -*-
class ProductAttributeValuesController < ApplicationController
  # 身份验证
  before_filter :authorize_admin!
  
  def index
    @product_attribute_values = ProductAttributeValue.order("id desc").page(params[:page])
  end
  
  def edit_values
    @product_attribute_define = ProductAttributeDefine.find(params[:define_id])    
  end

  def create
    @product_attribute_define = ProductAttributeDefine.find(params[:define_id])

    @product_attribute_value = ProductAttributeValue.new(params[:product_attribute_value])
    @product_attribute_value.name = @product_attribute_define.name
    @product_attribute_value.category_id = @product_attribute_define.category_id
    @product_attribute_value.product_attribute_define_id = @product_attribute_define.id

    respond_to do |format|
      if @product_attribute_value.save
        format.html { redirect_to :action => :edit_values, :define_id => params[:define_id] }
      else
        format.html { render :action => "edit_values" }
      end
    end
  end

  def update
    @product_attribute_value = ProductAttributeValue.find(params[:id])
    @product_attribute_define = ProductAttributeDefine.find(params[:define_id])

    respond_to do |format|
      if @product_attribute_value.update_attributes(params[:product_attribute_value])
        @product_attribute_value.product_attributes.each do |item|
          item.value = @product_attribute_value.value
          item.save
        end
        format.html { redirect_to :action => :edit_values, :define_id => params[:define_id] }
      else
        format.html { render :action => "edit_values" }
      end
    end
  end
end
