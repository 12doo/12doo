# -*- encoding : utf-8 -*-
class AddPicturesUpdateColumn < ActiveRecord::Migration
  def self.up
    add_column :pictures, :file_updated_at, :datetime
  end

  def self.down
    remove_column :pictures, :file_updated_at
  end
  
end
