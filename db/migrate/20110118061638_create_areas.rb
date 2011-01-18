class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.string :postcode
      t.string :province
      t.string :city
      t.string :region

      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
