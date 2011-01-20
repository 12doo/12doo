class CreateOrderChanges < ActiveRecord::Migration
  def self.up
    create_table :order_changes do |t|
      t.integer :user_id
      t.integer :order_id
      t.datetime :changed_at
      t.string :after
      t.string :before
      t.string :memo
      t.timestamps
    end
  end

  def self.down
    drop_table :order_changes
  end
end
