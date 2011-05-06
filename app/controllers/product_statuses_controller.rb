# -*- encoding : utf-8 -*-
class ProductStatusesController < ApplicationController
  # GET /product_statuses
  # GET /product_statuses.xml
  def index
    @product_statuses = ProductStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_statuses }
    end
  end

  # GET /product_statuses/1
  # GET /product_statuses/1.xml
  def show
    @product_status = ProductStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_status }
    end
  end

  # GET /product_statuses/new
  # GET /product_statuses/new.xml
  def new
    @product_status = ProductStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_status }
    end
  end

  # GET /product_statuses/1/edit
  def edit
    @product_status = ProductStatus.find(params[:id])
  end

  # POST /product_statuses
  # POST /product_statuses.xml
  def create
    @product_status = ProductStatus.new(params[:product_status])

    respond_to do |format|
      if @product_status.save
        format.html { redirect_to(@product_status, :notice => 'Product status was successfully created.') }
        format.xml  { render :xml => @product_status, :status => :created, :location => @product_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_statuses/1
  # PUT /product_statuses/1.xml
  def update
    @product_status = ProductStatus.find(params[:id])

    respond_to do |format|
      if @product_status.update_attributes(params[:product_status])
        format.html { redirect_to(@product_status, :notice => 'Product status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_statuses/1
  # DELETE /product_statuses/1.xml
  def destroy
    @product_status = ProductStatus.find(params[:id])
    @product_status.destroy

    respond_to do |format|
      format.html { redirect_to(product_statuses_url) }
      format.xml  { head :ok }
    end
  end
end
