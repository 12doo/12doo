# -*- encoding : utf-8 -*-
class ModifyTicketColumn < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :user_id
    add_column :tickets, :usable, :boolean, :default => true
  end

  def self.down
    add_column :tickets, :user_id, :integer
    remove_column :tickets, :usable
  end
end
