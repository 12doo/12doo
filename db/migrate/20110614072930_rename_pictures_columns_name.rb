# -*- encoding : utf-8 -*-
class RenamePicturesColumnsName < ActiveRecord::Migration
  def self.up
    rename_column :pictures, :name, :item_file_name
    rename_column :pictures, :content_type, :item_content_type
    rename_column :pictures, :file_size, :item_file_size
  end

  def self.down
    rename_column :pictures, :item_file_name, :name
    rename_column :pictures, :item_content_type, :content_type
    rename_column :pictures, :item_file_size, :file_size
  end
end
