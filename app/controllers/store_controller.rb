# -*- encoding : utf-8 -*-
class StoreController < ApplicationController
  def index
  end

  def search
    sku = []
    ProductTag.where("value like '%#{params[:key]}%'").each {|tag| sku << tag.product_sku }
    #@products = Product.joins(:product_tags).select("distinct(`products`.*)").where("product_tags.value like '%#{params[:key]}%'").uniq.paginate(:page => params[:page], :order => 'created_at DESC')
    @products = Product.where(:sku => sku).paginate(:page => params[:page], :order => 'created_at DESC')

    respond_to do |format|
      format.html { render "products/index" }
      format.xml  { render :xml => @products }
    end
  end
  
end
