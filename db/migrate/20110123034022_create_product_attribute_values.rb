class CreateProductAttributeValues < ActiveRecord::Migration
  def self.up
    create_table :product_attribute_values do |t|
      t.string :name
      t.string :short
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :product_attribute_values
  end
end
