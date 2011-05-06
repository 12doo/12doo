# -*- encoding : utf-8 -*-
class AddColumnsToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :default, :boolean
    add_column :addresses, :user_id, :integer
  end

  def self.down
    remove_column :addresses, :user_id
    remove_column :addresses, :default
  end
end
