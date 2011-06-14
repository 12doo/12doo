class RenamePicturesColumnName < ActiveRecord::Migration
  def self.up
    rename_column :pictures, :item, :item_file_name
  end

  def self.down
    rename_column :pictures, :item_file_name, :item
  end
end
