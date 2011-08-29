# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
  before_create :randomize_file_name
  after_save :set_price_attribute
  validates_presence_of :name, :memo,  :price, :status, :indication_price,  :sku, :count, :sold_count, :cn_name
  validates_numericality_of :price, :indication_price,:count, :sold_count
  validates_uniqueness_of :sku
  has_many :product_attributes
  has_many :product_tags
  cattr_reader :per_page
  paginates_per 20
  has_attached_file :pic_label,
                    :processors => [:watermark],
                    :styles => { :medium => {
                                              :geometry => "270x270>",
                                              :watermark_path => "#{Rails.root}/public/images/watermark.png"
                                            }
                              },
                    :url  => "/photos/products/:id/label/:style/:basename.:extension",
                    :path => "#{Rails.root}/public/photos/products/:id/label/:style/:basename.:extension"
                    
  has_attached_file :pic_main,
                    :processors => [:watermark],
                    :styles => { :medium => {
                                              :geometry => "270x270>",
                                              :watermark_path => "#{Rails.root}/public/images/watermark.png"
                                            },
                                  :thumb => {
                                              :geometry => "224x224>",
                                              :watermark_path => "#{Rails.root}/public/images/watermark.png"
                                            }
                              },
                    :url  => "/photos/products/:id/main/:style/:basename.:extension",
                    :path => "#{Rails.root}/public/photos/products/:id/main/:style/:basename.:extension"

  validates_attachment_presence :pic_main
  validates_attachment_size :pic_main, :less_than => 2.megabytes
  validates_attachment_content_type :pic_main, :content_type => ['image/jpeg', 'image/png']
  
  validates_attachment_presence :pic_label
  validates_attachment_size :pic_label, :less_than => 2.megabytes
  validates_attachment_content_type :pic_label, :content_type => ['image/jpeg', 'image/png']
  
  def current_price
    price = self.price
    if self.promo_price && self.promo_price > 0
      price = self.promo_price
    end
    price
  end
  
  def has_attribute(short,value)
    self.product_attributes.each do | attr |
      if attr.short == short && attr.value == value
        return true
      end
    end
    return false
  end
  
  # 添加到当前属性集合
  def add_attribute(short,value)
    if short && value
      if !self.has_attribute(short,value)
        define = ProductAttributeDefine.find_by_short(short)
        if define
          # 如果是固定值属性
          if define.fix
            value = ProductAttributeValue.where(:short => short,:value => value).first
            if value
              temp = ProductAttribute.new
              temp.init_from_value(value.id)
              temp.product_sku = self.sku
              self.product_attributes << temp
            end
          else
            temp = ProductAttribute.new
            temp.init_from_define(define.id)
            temp.value = value
            temp.product_sku = self.sku
            self.product_attributes << temp
          end
        end
      end
    end
  end
  
  def update_attribute(short,old_value,new_value)
    if short
      values = self.product_attributes.where(:short => short, :value => old_value)
      values.each do |item|
        item.value == new_value
        self.product_attributes << item
      end
    end
  end
  
  def set_attributes(short,values)
    if short
      self.product_attributes.each do |item|
        if !values.include?item.value
          self.remove_attribute(short,item.value)
        end
      end
      
      values.each do |item|
        add_attribute(short,item)
      end
    end
  end
  
  def remove_attribute(short,value)
    if short && value
      values = self.product_attributes.where(:short => short, :value => value)
      self.product_attributes.delete(values)
    end
  end
  
  # TODO: 需要修改成判断多个值的方式
  def get_attribute_value(short)
    value = ''
    self.product_attributes.find_all_by_short(short).each_with_index do | attr , index|
      if index > 0 
        value = value + '，' + attr.value
      else
        value = attr.value
      end 
    end
    
    return value
  end
  
  private  
  def randomize_file_name  
    #archives 就是你在 has_attached_file :archives 使用的名字  
    extension = File.extname(pic_main.original_filename).downcase  
    #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
    self.pic_main.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")  
    
    extension = File.extname(pic_label.original_filename).downcase  
    #你可以改成你想要的文件名，把下面这个方法的第二个参数随便改了就可以了。  
    self.pic_label.instance_write(:file_name, "#{Time.now.strftime("%Y%m%d%H%M%S")}#{rand(1000)}#{extension}")  
  
  end
  
  def set_price_attribute
    price = current_price
    item = ProductAttribute.where(:short => 'price', :product_id => self.id).first

    if item
      string = '600以上'
      if price < 100
        string = '99以下'
      elsif price >= 100 and price < 200
        string = '100~199'
      elsif price >= 200 and price < 300
        string = '200~299'
      elsif price >= 300 and price < 600
        string = '300~599'
      end
    
      value = ProductAttributeValue.where(:short => 'price', :value => string).first
      item.value = value.value
      item.product_attribute_value_id = value.id
    
      item.save
    end
      
    return true
  end
  
end
