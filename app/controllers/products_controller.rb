# -*- encoding : utf-8 -*-
class ProductsController < ApplicationController

  # 身份验证  
  before_filter :authorize_admin!, :except => [:query_result, :show]
  
  def index
    @products = Product.order("id desc").page(params[:page])
  end
  
  def query_result
    sort_by = "created_at"
    sort = "desc"
    if params[:sort] && params[:sort] == "0"
      sort = "asc"
    end
    
    if params[:sort_by]
      sort_by = params[:sort_by]
    end
    
    if (params[:tags] == nil) && (params[:keywords] == nil)
      @products = Product.where(:visiable => true).order('id desc').page(params[:page]).per(9)#.paginate(:page => params[:page], :order => sort_by + ' ' + sort , :conditions => "visiable = true")
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
      
      skus = []
      sku.each do |item|
        skus << item.product_sku
      end
      
      #@products = Product.where(:sku => skus, :visiable => true).order('id desc').page(params[:page])
      @products = Product.where("(sku in (:skus) or cn_name like :cn_name or name like :name) and visiable = :visiable", :skus => skus, :cn_name => "%#{params[:keywords]}%", :name => "%#{params[:keywords]}%", :visiable => true).order('id desc').page(params[:page])
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
          value = ProductAttributeValue.find(:first,:conditions => {:name => attri[:name],:value => attri[:value]})
          temp = ProductAttribute.new
          temp.short = define.short
          temp.description = define.description
          if value
            temp.product_attribute_value_id = value.id
          end
          
          temp.fix = define.fix
          temp.multiple = define.multiple
          temp.name = attri[:name]
          temp.value = attri[:value]
          temp.product_sku = @product.sku
          temp.save
        end
      end
    end
    
    @product.pic = ''
    # save pic
    if params[:product][:pic]
      
      #create path
      directory = "public/pics"
      unless File.directory?directory
        Dir.mkdir(directory)
      end
      
      name = params[:product][:pic].original_filename
      @product.pic = name

      #create path
      directory = directory + "/" + @product.sku
      path = File.join(directory, name)
      unless File.directory?directory
        Dir.mkdir(directory)
      end
      #save file
      File.open(path, "wb") { |f| f.write(params[:product][:pic].read) }
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
    
    @product.sku = params[:product][:sku]
    @product.name = params[:product][:name]
    @product.cn_name = params[:product][:cn_name]
    @product.price = params[:product][:price]
    @product.indication_price = params[:product][:indication_price]
    @product.memo = params[:product][:memo]
    @product.status = params[:product][:status]
    @product.count = params[:product][:count]
    @product.sold_count = params[:product][:sold_count]
    @product.visiable = params[:product][:visiable]
    
    @product.product_attributes.each do |item|
      item.destroy
    end
    if params[:product_attribute]
      params[:product_attribute].each do |attri|
        if attri[:value] && attri[:value] != ''
          define = ProductAttributeDefine.find_by_name(attri[:name])
          value = ProductAttributeValue.find(:first,:conditions => {:name => attri[:name],:value => attri[:value]})
          temp = ProductAttribute.new
          temp.short = define.short
          temp.description = define.description
          temp.product_attribute_value_id = value.id
          temp.fix = define.fix
          temp.multiple = define.multiple
          temp.name = attri[:name]
          temp.value = attri[:value]
          temp.product_sku = @product.sku
          temp.save
        end
      end
    end
    
    if params[:product][:pic]
      
      #create path
      directory = "public/pics"
      unless File.directory?directory
        Dir.mkdir(directory)
      end
      
      name = params[:product][:pic].original_filename
      @product.pic = name

      #create path
      directory = directory + "/" + @product.sku
      path = File.join(directory, name)
      unless File.directory?directory
        Dir.mkdir(directory)
      end
      #save file
      File.open(path, "wb") { |f| f.write(params[:product][:pic].read) }
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
      if @product.save
        format.html { redirect_to :action => "products", :controller => "admin" }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def bought  
    @items = Product.joins('LEFT OUTER JOIN order_items ON order_items.product_id = products.id').where("order_items.user_id" => current_user.id)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to :action => :products, :controller => :admin  }
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
