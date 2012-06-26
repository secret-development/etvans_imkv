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

ActiveRecord::Schema.define(:version => 20120413075233) do

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "condition_fields", :force => true do |t|
    t.string   "namefield"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "typefield"
    t.integer  "typesubject_id"
  end

  create_table "customeraccesses", :force => true do |t|
    t.boolean "access"
  end

  create_table "customers", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phonehome"
    t.string   "phonemobile"
    t.string   "email"
    t.text     "note"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "potentials",         :default => false
    t.integer  "social_status_id"
    t.integer  "typetransaction_id"
    t.datetime "lastcall"
    t.integer  "user_id"
  end

  add_index "customers", ["firstname", "lastname"], :name => "index_rcustomers_on_firstname_and_lastname"

  create_table "districts", :force => true do |t|
    t.integer  "city_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "districts", ["title"], :name => "index_districts_on_title"

  create_table "documents", :force => true do |t|
    t.integer  "transaction_id"
    t.string   "doc"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "paginators", :force => true do |t|
    t.string  "resource"
    t.integer "paginate"
  end

  create_table "phones", :force => true do |t|
    t.string  "customerphone"
    t.integer "customer_id"
  end

  create_table "photos", :force => true do |t|
    t.integer  "subject_id"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "properties", :force => true do |t|
    t.string  "condition"
    t.string  "value"
    t.integer "subject_id"
    t.string  "typefield"
  end

  create_table "residents", :force => true do |t|
    t.string  "title"
    t.integer "city_id"
  end

  create_table "social_statuses", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.integer  "typesubject_id"
    t.integer  "city_id"
    t.integer  "price"
    t.float    "area"
    t.string   "address"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "typetransaction_id"
    t.integer  "customer_id"
    t.integer  "district_id"
    t.integer  "floor"
    t.string   "street_src"
    t.string   "house_src"
    t.string   "flat_src"
    t.integer  "user_id"
    t.boolean  "active",             :default => true
    t.string   "price_currency"
    t.integer  "room"
    t.integer  "resident_id"
    t.integer  "floorall"
    t.text     "note"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "deadline"
    t.boolean  "done"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "admin"
    t.string   "user_lastname"
  end

  create_table "transactions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "customer_id"
    t.integer  "user_id"
    t.integer  "typetransaction_id"
    t.integer  "subject_id"
    t.integer  "price"
    t.boolean  "payment"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.boolean  "admin"
    t.string   "price_currency"
    t.string   "user_lastname"
  end

  create_table "typesubjects", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "floor"
    t.boolean  "room"
    t.boolean  "resident"
  end

  create_table "typetransactions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "role"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phonemobile"
    t.string   "phonehome"
    t.boolean  "fired",                  :default => false
    t.datetime "last_sign_in_at"
  end

  create_table "value_fields", :force => true do |t|
    t.string   "valuefield"
    t.integer  "condition_field_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "worktimes", :force => true do |t|
    t.integer "start_hour"
    t.integer "start_min"
    t.integer "end_hour"
    t.integer "end_min"
  end

end
