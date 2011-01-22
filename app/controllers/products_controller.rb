class ProductsController < ApplicationController

  # 身份验证  
  before_filter :authorize_admin!, :except => [:index, :show]
  
  def index
    @products = Product.paginate :page => params[:page], :order => 'created_at desc', :conditions => "visiable = true"
  end

  def show
    @product = Product.find(params[:id])
    unless @product.visiable
      redirect_to :action => "index"
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
  end
  
  def create
    @product = Product.new(params[:product])
    
    if params[:product_attribute]
      params[:product_attribute].each do |attri|
        if attri[:value] && attri[:value] != ''
          define = ProductAttributeDefine.find_by_name(attri[:name])
          if define.multiple
            attri[:value].split(",").each do |value|
              temp = ProductAttribute.new
              temp.short = define.short
              temp.description = define.description
              temp.name = attri[:name]
              temp.value = value
              temp.product_sku = @product.sku
              temp.save
            end
          else
              temp = ProductAttribute.new
              temp.short = define.short
              temp.description = define.description
              temp.name = attri[:name]
              temp.value = attri[:value]
              temp.product_sku = @product.sku
              temp.save
          end
        end
      end
    end
    #params[:product_tag].each do |tag|
    #  temp = ProductTag.new
    #  temp.key = tag[:key]
    #  temp.value = tag[:value]
    #  temp.product_sku = @product.sku
    #  temp.save
    #end
    respond_to do |format|
      if @product.save
        format.html { redirect_to :action => "products", :controller => "admin" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
    @statuses = ProductStatus.all
    @years = (Time.now.year).downto(Time.now.year - 30).map{ |x| x }
  end

  def update
    @product = Product.find(params[:id])
    params[:product_attribute].each do |attri|
      temp = @product.product_attributes.find(:first,:conditions => { :name => attri[:name] })
      temp.value = attri[:value]
      temp.save
    end
    #params[:product_tag].each do |tag|
    #  if tag[:key] != ""
    #    temp = @product.product_tags.find(:first,:conditions => {:key => tag[:key]})
    #    if temp == nil
    #      temp = ProductTag.new
    #     temp.key = tag[:key]
    #     temp.product_sku = @product.sku
    #   end
    #   temp.value = tag[:value]
    #   temp.save
    #  end
    #end
    
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to :action => "products", :controller => "admin" }
      else
        format.html { render :action => "edit" }
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
