class CreateProductAttributeDefines < ActiveRecord::Migration
  def self.up
    create_table :product_attribute_defines do |t|
      t.string :name
      t.string :short
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :product_attribute_defines
  end
end
