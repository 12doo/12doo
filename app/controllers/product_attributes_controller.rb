# -*- encoding : utf-8 -*-
class ProductAttributesController < ApplicationController
  # 身份验证
  before_filter :authorize_admin!
  
  # GET /product_attributes
  # GET /product_attributes.xml
  def index
    @product_attributes = ProductAttribute.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_attributes }
    end
  end

  # GET /product_attributes/1
  # GET /product_attributes/1.xml
  def show
    @product_attribute = ProductAttribute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_attribute }
    end
  end

  # GET /product_attributes/new
  # GET /product_attributes/new.xml
  def new
    @product_attribute = ProductAttribute.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_attribute }
    end
  end

  # GET /product_attributes/1/edit
  def edit
    @product_attribute = ProductAttribute.find(params[:id])
  end

  # POST /product_attributes
  # POST /product_attributes.xml
  def create
    @product_attribute = ProductAttribute.new(params[:product_attribute])

    respond_to do |format|
      if @product_attribute.save
        format.html { redirect_to(@product_attribute, :notice => 'Product attribute was successfully created.') }
        format.xml  { render :xml => @product_attribute, :status => :created, :location => @product_attribute }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_attribute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_attributes/1
  # PUT /product_attributes/1.xml
  def update
    @product_attribute = ProductAttribute.find(params[:id])

    respond_to do |format|
      if @product_attribute.update_attributes(params[:product_attribute])
        format.html { redirect_to(@product_attribute, :notice => 'Product attribute was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_attribute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_attributes/1
  # DELETE /product_attributes/1.xml
  def destroy
    @product_attribute = ProductAttribute.find(params[:id])
    @product_attribute.destroy

    respond_to do |format|
      format.html { redirect_to(product_attributes_url) }
      format.xml  { head :ok }
    end
  end
end
