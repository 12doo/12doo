class ProductsController < ApplicationController

  def index
    @products = Product.paginate :page => params[:page], :order => 'created_at DESC'
  end

  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def new
    @product = Product.new
    @statuses = ProductStatus.all
    @years = (Time.now.year).downto(Time.now.year - 30).map{ |x| x }
    attributeDef = ProductAttributeDefine.all

    attributeDef.each do |x|
      temp = ProductAttribute.new
      temp.name   = x.name
      temp.short = x.short
      temp.description = x.description
      @product.product_attributes << temp
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def edit
    @product = Product.find(params[:id])
    @statuses = ProductStatus.all
    @years = (Time.now.year).downto(Time.now.year - 30).map{ |x| x }
  end

  def create
    @product = Product.new(params[:product])
    #need update: use tran save 
    params[:product_attribute].each do |attri|
      temp = ProductAttribute.new
      temp.name = attri[:name]
      temp.value = attri[:value]
      temp.product_sku = @product.sku
      temp.save
    end
    params[:product_tag].each do |tag|
      temp = ProductTag.new
      temp.key = tag[:key]
      temp.value = tag[:value]
      temp.product_sku = @product.sku
      temp.save
    end
    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @product = Product.find(params[:id])
    params[:product_attribute].each do |attri|
      temp = @product.product_attributes.find(:first,:conditions => { :name => attri[:name] })
      temp.value = attri[:value]
      temp.save
    end
    params[:product_tag].each do |tag|
      if tag[:key] != ""
        temp = @product.product_tags.find(:first,:conditions => {:key => tag[:key]})
        if temp == nil
          temp = ProductTag.new
          temp.key = tag[:key]
          temp.product_sku = @product.sku
        end
        temp.value = tag[:value]
        temp.save
      end
    end
    
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
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
