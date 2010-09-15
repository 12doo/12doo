class ProductAttributeDefinesController < ApplicationController
  # GET /product_attribute_defines
  # GET /product_attribute_defines.xml
  def index
    @product_attribute_defines = ProductAttributeDefine.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_attribute_defines }
    end
  end

  # GET /product_attribute_defines/1
  # GET /product_attribute_defines/1.xml
  def show
    @product_attribute_define = ProductAttributeDefine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_attribute_define }
    end
  end

  # GET /product_attribute_defines/new
  # GET /product_attribute_defines/new.xml
  def new
    @product_attribute_define = ProductAttributeDefine.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_attribute_define }
    end
  end

  # GET /product_attribute_defines/1/edit
  def edit
    @product_attribute_define = ProductAttributeDefine.find(params[:id])
  end

  # POST /product_attribute_defines
  # POST /product_attribute_defines.xml
  def create
    @product_attribute_define = ProductAttributeDefine.new(params[:product_attribute_define])

    respond_to do |format|
      if @product_attribute_define.save
        format.html { redirect_to(@product_attribute_define, :notice => 'Product attribute define was successfully created.') }
        format.xml  { render :xml => @product_attribute_define, :status => :created, :location => @product_attribute_define }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_attribute_define.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_attribute_defines/1
  # PUT /product_attribute_defines/1.xml
  def update
    @product_attribute_define = ProductAttributeDefine.find(params[:id])

    respond_to do |format|
      if @product_attribute_define.update_attributes(params[:product_attribute_define])
        format.html { redirect_to(@product_attribute_define, :notice => 'Product attribute define was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_attribute_define.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_attribute_defines/1
  # DELETE /product_attribute_defines/1.xml
  def destroy
    @product_attribute_define = ProductAttributeDefine.find(params[:id])
    @product_attribute_define.destroy

    respond_to do |format|
      format.html { redirect_to(product_attribute_defines_url) }
      format.xml  { head :ok }
    end
  end
end
