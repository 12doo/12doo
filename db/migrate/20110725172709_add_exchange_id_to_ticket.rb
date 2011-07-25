class AddExchangeIdToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :exchange_id, :integer
  end

  def self.down
    remove_column :tickets, :exchange_id
  end
end
