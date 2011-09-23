# -*- encoding : utf-8 -*-
class AddCateName < ActiveRecord::Migration
  def self.up
    add_column :categories, :short, :string
  end

  def self.down
    remove_column :categories, :short
  end
end
