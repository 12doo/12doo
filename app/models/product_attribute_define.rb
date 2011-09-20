# -*- encoding : utf-8 -*-
class ProductAttributeDefine < ActiveRecord::Base
  
  belongs_to :category
  has_many :product_attribute_values
  paginates_per 20
  
  def values
    ProductAttributeValue.where(:name => self.name).order("sort desc")
  end
  
  def get_values
    returns = ''
    ProductAttributeValue.where(:name => self.name).order("sort desc").each { |item| returns += item.value + ',' }
    returns
  end
  
  def save_values(values)
    exists = ProductAttributeValue.where(:name => self.name)
    news = values.split(',');
    exists.each do |item|
      unless news.include?(item.value)
        item.destroy
      end
    end

    news.each do |item|
      flag = true;
      exists.each do |exist|
        if exist.value == item
          flag = false
          break
        end
      end
      if flag
        value = ProductAttributeValue.new
        value.value = item
        value.short = self.short
        value.sort = self.sort
        value.name = self.name
        value.save
      end
    end
  end
end
