# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110928160916) do

  create_table "addresses", :force => true do |t|
    t.string   "detail"
    t.string   "province"
    t.string   "city"
    t.string   "region"
    t.string   "zip"
    t.string   "phone"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default"
    t.integer  "user_id"
  end

  create_table "alipay_logs", :force => true do |t|
    t.string   "notify_type"
    t.string   "notify_id"
    t.string   "out_trade_no"
    t.string   "trade_no"
    t.string   "payment_type"
    t.string   "subject"
    t.string   "body"
    t.string   "seller_email"
    t.string   "seller_id"
    t.string   "buyer_email"
    t.string   "buyer_id"
    t.decimal  "price",         :precision => 10, :scale => 2
    t.integer  "quantity"
    t.decimal  "total_fee",     :precision => 10, :scale => 2
    t.string   "trade_status"
    t.string   "refund_status"
    t.datetime "notify_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", :force => true do |t|
    t.string   "postcode"
    t.string   "province"
    t.string   "city"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short"
  end

  create_table "coupon_used_records", :force => true do |t|
    t.integer  "coupon_id"
    t.string   "coupon_code"
    t.integer  "user_id"
    t.datetime "use_at"
    t.string   "order_id"
    t.string   "order_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", :force => true do |t|
    t.string   "code"
    t.decimal  "discount",    :precision => 10, :scale => 2
    t.decimal  "threshold",   :precision => 10, :scale => 2
    t.integer  "category_id"
    t.integer  "user_id"
    t.boolean  "one_off"
    t.datetime "begin"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "used_time",                                  :default => 0
    t.string   "memo",                                       :default => ""
  end

  create_table "deliveries", :force => true do |t|
    t.integer  "area_id"
    t.decimal  "door_step",  :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dispatch_items", :force => true do |t|
    t.integer  "dispatch_id"
    t.integer  "product_id"
    t.string   "product_name"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "product_price", :precision => 10, :scale => 2
    t.decimal  "subtotal",      :precision => 10, :scale => 2
    t.string   "product_sku"
  end

  create_table "dispatches", :force => true do |t|
    t.string   "no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "order_no"
    t.decimal  "order_total",         :precision => 10, :scale => 2
    t.decimal  "order_carriage",      :precision => 10, :scale => 2
    t.string   "order_fullname"
    t.string   "order_address"
    t.string   "order_province"
    t.string   "order_city"
    t.string   "order_region"
    t.string   "order_zip"
    t.string   "order_phone"
    t.string   "order_delivery_type"
    t.decimal  "order_pay_price",     :precision => 10, :scale => 2
    t.decimal  "order_discount",      :precision => 10, :scale => 2
    t.decimal  "order_quantity",      :precision => 10, :scale => 0
    t.string   "order_memo"
    t.string   "order_pay_type"
  end

  create_table "emails", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.integer  "last_send_attempt", :default => 0
    t.text     "mail"
    t.datetime "created_on"
  end

  create_table "exchanges", :force => true do |t|
    t.string   "no"
    t.string   "address"
    t.string   "province"
    t.string   "city"
    t.string   "region"
    t.string   "zip"
    t.string   "phone"
    t.string   "memo"
    t.datetime "expected_time"
    t.integer  "count"
    t.string   "status"
    t.string   "fullname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.decimal  "price",      :precision => 10, :scale => 2
    t.boolean  "deleted",                                   :default => false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_changes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.datetime "changed_at"
    t.string   "after"
    t.string   "before"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.string   "order_no"
    t.integer  "quantity"
    t.decimal  "price",        :precision => 10, :scale => 2
    t.decimal  "subtotal",     :precision => 10, :scale => 2
    t.string   "product_name"
    t.string   "product_sku"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.integer  "user_id"
    t.integer  "product_id"
  end

  create_table "order_statuses", :force => true do |t|
    t.string   "short"
    t.string   "display"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "no"
    t.decimal  "total",           :precision => 10, :scale => 2
    t.string   "status"
    t.datetime "order_at"
    t.datetime "delivery_at"
    t.integer  "address_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fullname"
    t.string   "address"
    t.string   "province"
    t.string   "city"
    t.string   "region"
    t.string   "zip"
    t.string   "phone"
    t.string   "delivery_type"
    t.decimal  "carriage",        :precision => 10, :scale => 2
    t.string   "coupon_code"
    t.decimal  "discount",        :precision => 10, :scale => 2
    t.decimal  "quantity",        :precision => 10, :scale => 0, :default => 0
    t.string   "pay_type",                                       :default => ""
    t.datetime "pay_at"
    t.string   "memo",                                           :default => ""
    t.decimal  "pay_price",       :precision => 10, :scale => 2
    t.decimal  "coupon_discount", :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "discount_rate",   :precision => 10, :scale => 2, :default => 1.0
  end

  create_table "pictures", :force => true do |t|
    t.string   "item_file_name"
    t.string   "item_content_type"
    t.integer  "item_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "file_updated_at"
  end

  create_table "product_attribute_defines", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "multiple",    :default => false
    t.integer  "sort",        :default => 0
    t.boolean  "search",      :default => false
    t.boolean  "fix",         :default => true
    t.boolean  "detail",      :default => true
    t.integer  "category_id", :default => 0
  end

  create_table "product_attribute_values", :force => true do |t|
    t.string   "name"
    t.integer  "sort"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_attribute_define_id", :default => 0
    t.integer  "category_id",                 :default => 0
  end

  create_table "product_attributes", :force => true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_attribute_value_id",  :default => 0
    t.integer  "product_id"
    t.integer  "product_attribute_define_id", :default => 0
    t.integer  "category_id",                 :default => 0
  end

  create_table "product_statuses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "sku"
    t.decimal  "price",                  :precision => 10, :scale => 2
    t.decimal  "indication_price",       :precision => 10, :scale => 2
    t.text     "memo"
    t.string   "status"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visiable",                                              :default => false
    t.string   "cn_name"
    t.integer  "sold_count"
    t.string   "pic_label_file_name"
    t.string   "pic_label_content_type"
    t.integer  "pic_label_file_size"
    t.string   "pic_main_file_name"
    t.string   "pic_main_content_type"
    t.integer  "pic_main_file_size"
    t.boolean  "promo",                                                 :default => false
    t.datetime "pic_main_updated_at"
    t.datetime "pic_label_updated_at"
    t.decimal  "promo_price",            :precision => 10, :scale => 2, :default => 0.0
    t.integer  "category_id"
    t.string   "template_name",                                         :default => ""
  end

  create_table "tickets", :force => true do |t|
    t.string   "code"
    t.integer  "product_id"
    t.datetime "used_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "usable",      :default => true
    t.integer  "exchange_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.string   "name"
    t.string   "title"
    t.datetime "birth"
    t.string   "gender"
    t.string   "ref"
    t.string   "reset_phone_token"
    t.string   "reset_email_token"
    t.boolean  "admin",                               :default => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "wikis", :force => true do |t|
    t.string   "category"
    t.string   "title"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
