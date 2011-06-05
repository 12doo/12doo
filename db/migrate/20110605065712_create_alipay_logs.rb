class CreateAlipayLogs < ActiveRecord::Migration
  def self.up
    create_table :alipay_logs do |t|
      t.string :notify_type
      t.string :notify_id
      t.string :out_trade_no
      t.string :trade_no
      t.string :payment_type
      t.string :subject
      t.string :body
      t.string :seller_email
      t.string :seller_id
      t.string :buyer_email
      t.string :buyer_id
      t.decimal :price
      t.integer :quantity
      t.decimal :total_fee
      t.string :trade_status
      t.string :refund_status
      t.datetime :notify_time
      
      t.timestamps
    end
  end

  def self.down
    drop_table :alipay_logs
  end
end
