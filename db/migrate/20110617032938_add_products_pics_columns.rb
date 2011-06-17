class AddProductsPicsColumns < ActiveRecord::Migration
  def self.up
    add_column :products, :pic_main_updated_at, :datetime
    add_column :products, :pic_label_updated_at, :datetime 
  end

  def self.down
    remove_column :products, :pic_main_updated_at
    remove_column :products, :pic_label_updated_at
  end
end
