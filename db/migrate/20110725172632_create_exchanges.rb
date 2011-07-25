class CreateExchanges < ActiveRecord::Migration
  def self.up
    create_table :exchanges do |t|
      t.string :no
      t.string :address
      t.string :province
      t.string :city
      t.string :region
      t.string :zip
      t.string :phone
      t.string :memo
      t.datetime :expected_time
      t.integer :count
      t.string :status
      t.string :fullname

      t.timestamps
    end
  end

  def self.down
    drop_table :exchanges
  end
end
