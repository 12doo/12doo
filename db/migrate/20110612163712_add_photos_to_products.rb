class AddPhotosToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :pic_label_file_name, :string
    add_column :products, :pic_label_content_type, :string
    add_column :products, :pic_label_file_size, :integer
    
    add_column :products, :pic_main_file_name, :string
    add_column :products, :pic_main_content_type, :string
    add_column :products, :pic_main_file_size, :integer
  end

  def self.down
    remove_column :products, :pic_label_file_size
    remove_column :products, :pic_label_content_type
    remove_column :products, :pic_label_file_name
  
    remove_column :products, :pic_main_file_size
    remove_column :products, :pic_main_content_type
    remove_column :products, :pic_main_file_name
  end
end
