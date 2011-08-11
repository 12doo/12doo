class ChangeWikiColumnNamespaceToCategory < ActiveRecord::Migration
  def self.up
    rename_column :wikis, :namespace, :category
  end

  def self.down
    rename_column :wikis, :category, :namespace
  end
end
