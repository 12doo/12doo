# -*- encoding : utf-8 -*-
class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :phone, :string
    add_column :users, :name, :string
    add_column :users, :title, :string
    add_column :users, :birth, :datetime
    add_column :users, :gender, :string
    add_column :users, :ref, :string
    add_index :users, :phone,                :unique => true
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :name
    remove_column :users, :title
    remove_column :users, :birth
    remove_column :users, :gender
    remove_column :users, :ref
    remove_index :users, :phone
  end
end
