class ProductsController < ApplicationController

  # 身份验证  
  before_filter :authorize_admin!, :except => [:index, :show]
  
  def index
    if (params[:tags] == nil) && (params[:keywords] == nil)
      @products = Product.paginate(:page => params[:page], :order => 'created_at desc', :conditions => "visiable = true")
    else
      sku = []
      
      if params[:tags] == nil && params[:keywords] && params[:keywords] != ''
        # 如果tag为空,keywords不为空
        sku = ProductAttribute.select("distinct(product_sku)").where("value like :keywords", :keywords => "%#{params[:keywords]}%")
      elsif params[:keywords] == nil && params[:tags] && params[:tags] != ''
        # 如果keywords为空,tags不为空
        sku = ProductAttribute.select("distinct(product_sku)").where(join_for_where)
      else
        # 如果都不为空
        sku = ProductAttribute.select("distinct(product_sku)").where(join_for_where).where("value like :keywords", :keywords => "%#{params[:keywords]}%")
      end
      
      @products = Product.where(:sku => sku, :visiable => true).paginate(:page => params[:page], :order => 'created_at desc')
    end
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
    @attributes = ProductAttributeDefine.all
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
    @attributes = ProductAttributeDefine.all
  end

  def update
    @product = Product.find(params[:id])
    @product.product_attributes.each do |item|
      item.destroy
    end
    if params[:product_attribute]
      params[:product_attribute].each do |attri|
        if attri[:value] && attri[:value] != ''
          define = ProductAttributeDefine.find_by_name(attri[:name])
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
  
  def join_for_in(a)
    returns = '('
    flag = 0
    a.each do |item|
      if item && item != '' && item != "0"
        if flag == 0
          returns += "#{item}"
          flag += 1
        else
          returns += ",#{item}"
          flag += 1
        end
      end
    end
    returns += ')'
  end
  
  def join_for_where
    returns = ''
    flag = 0
    params[:tags].split('-').each do |item|
      if item && item != '' && item != "0"
        if flag == 0
          returns += "product_attribute_value_id in #{join_for_in(item.split(','))}"
          flag += 1
        else
          returns += " and product_attribute_value_id in #{join_for_in(item.split(','))}"
          flag += 1
        end
      end
    end
    returns
  end
end
