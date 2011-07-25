class CreateTicketUsedRecords < ActiveRecord::Migration
  def self.up
    create_table :ticket_used_records do |t|
      t.integer :ticket_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_used_records
  end
end
