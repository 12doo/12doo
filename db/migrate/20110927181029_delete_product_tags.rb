class DeleteProductTags < ActiveRecord::Migration
  def self.up
    drop_table :product_tags
  end

  def self.down
    create_table :product_tags do |t|
      t.string :product_sku
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
