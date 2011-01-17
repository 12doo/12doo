class RemovePhoneIndexFromUsers < ActiveRecord::Migration
  def self.up
    remove_index :users, :phone
  end

  def self.down
    add_index :users, :phone, :unique => true
  end
end
