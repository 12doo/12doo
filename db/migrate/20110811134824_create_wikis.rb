# -*- encoding : utf-8 -*-
class CreateWikis < ActiveRecord::Migration
  def self.up
    create_table :wikis do |t|
      t.string :namespace
      t.string :title
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :wikis
  end
end
