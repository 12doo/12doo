# -*- encoding : utf-8 -*-
class ProductAttributeValuesController < ApplicationController
  # 身份验证
  before_filter :authorize_admin!

  def new
    @product_attribute_define = ProductAttributeDefine.find(params[:define_id])
  end
  
  def edit_values
    @product_attribute_define = ProductAttributeDefine.find(params[:define_id])    
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
    @product_attribute_value = ProductAttributeValue.find(params[:id])

    respond_to do |format|
      if @product_attribute_value.update_attributes(params[:product_attribute_value])
        format.html { redirect_to :action => :edit_values, :define_id => params[:define_id]  }
      else
        @product_attribute_define = ProductAttributeDefine.find(params[:define_id])
        format.html { render :action => "edit_values" }
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
