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

ActiveRecord::Schema.define(:version => 20110117032939) do

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

  create_table "order_items", :force => true do |t|
    t.string   "order_no"
    t.integer  "quantity"
    t.decimal  "price",        :precision => 10, :scale => 0
    t.decimal  "subtotal",     :precision => 10, :scale => 0
    t.string   "product_name"
    t.string   "product_sku"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "no"
    t.decimal  "total",       :precision => 10, :scale => 0
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
  end

  create_table "product_attribute_defines", :force => true do |t|
    t.string   "name"
    t.string   "short"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_attributes", :force => true do |t|
    t.string   "product_sku"
    t.string   "name"
    t.string   "short"
    t.string   "description"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_statuses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_tags", :force => true do |t|
    t.string   "product_sku"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "sku"
    t.decimal  "price",            :precision => 10, :scale => 0
    t.decimal  "indication_price", :precision => 10, :scale => 0
    t.string   "memo"
    t.string   "status"
    t.integer  "count"
    t.integer  "vintage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["phone"], :name => "index_users_on_phone", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
