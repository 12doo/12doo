# -*- encoding : utf-8 -*-
class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.column :name, :string
      t.column :content_type, :string
      t.column :file_size, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
