class AddTestDataProductTag < ActiveRecord::Migration
  def self.up
    ProductTag.delete_all 
    ProductTag.create(:product_sku => 'ABCDE', :key => 'key key key', :value => 'key value key value key value')
    ProductTag.create(:product_sku => 'ABCDE', :key => 'Status1 description', :value => 'abcdefg sky')
    ProductTag.create(:product_sku => 'ABCDE', :key => 'Status2 description', :value => 'abceddfadf')
    ProductTag.create(:product_sku => 'ABCDE', :key => 'Status3 description', :value => 'ndsi psp wii oop body')
  end

  def self.down
    ProductTag.delete_all 
  end
end
