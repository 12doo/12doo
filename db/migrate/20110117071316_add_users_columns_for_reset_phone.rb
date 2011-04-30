# -*- encoding : utf-8 -*-
class AddUsersColumnsForResetPhone < ActiveRecord::Migration
  def self.up
    add_column :users, :reset_phone_token, :string
    add_column :users, :reset_email_token, :string
  end

  def self.down
    remove_column :users, :reset_phone_token
    remove_column :users, :reset_email_token
  end
end
