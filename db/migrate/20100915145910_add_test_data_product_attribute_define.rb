class AddTestDataProductAttributeDefine < ActiveRecord::Migration
  def self.up
    ProductAttributeDefine.delete_all 
    ProductAttributeDefine.create(:name => 'Attr0', :short => 'Attr0', :description => 'Attr0 description')
    ProductAttributeDefine.create(:name => 'Attr1', :short => 'Attr1', :description => 'Attr1 description')
    ProductAttributeDefine.create(:name => 'Attr2', :short => 'Attr2', :description => 'Attr2 description')
    ProductAttributeDefine.create(:name => 'Attr3', :short => 'Attr3', :description => 'Attr3 description')
  end

  def self.down
    ProductAttributeDefine.delete_all 
  end
end
