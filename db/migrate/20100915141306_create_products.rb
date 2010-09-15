class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.decimal :price
      t.decimal :indication_price
      t.string :memo
      t.string :status
      t.integer :count
      t.integer :vintage

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
