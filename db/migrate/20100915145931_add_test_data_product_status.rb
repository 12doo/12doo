class AddTestDataProductStatus < ActiveRecord::Migration
  def self.up
    ProductStatus.delete_all 
    ProductStatus.create(:name => 'Status0', :description => 'Status0 description')
    ProductStatus.create(:name => 'Status1', :description => 'Status1 description')
    ProductStatus.create(:name => 'Status2', :description => 'Status2 description')
    ProductStatus.create(:name => 'Status3', :description => 'Status3 description')
  end

  def self.down
    ProductStatus.delete_all 
  end
end
