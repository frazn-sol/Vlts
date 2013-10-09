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

ActiveRecord::Schema.define(:version => 20131009151401) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "admin_id"
    t.string   "roles"
    t.string   "roles_mask"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "business_managers", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.integer  "phone1"
    t.integer  "phone2"
    t.string   "website"
    t.string   "email"
    t.string   "role"
    t.string   "username"
    t.string   "password"
    t.string   "passwordhint"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "contact_people", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.integer  "phone1"
    t.integer  "phone2"
    t.string   "website"
    t.string   "email"
    t.string   "role"
    t.string   "username"
    t.string   "password"
    t.string   "passwordhint"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "customers", :force => true do |t|
    t.integer  "admin_id"
    t.integer  "customer_id"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "roles"
    t.string   "roles_mask"
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.integer  "phone1"
    t.integer  "phone2"
    t.string   "website"
    t.string   "role"
    t.string   "username"
    t.string   "password"
    t.string   "passwordhint"
  end

  add_index "customers", ["email"], :name => "index_customers_on_email", :unique => true
  add_index "customers", ["reset_password_token"], :name => "index_customers_on_reset_password_token", :unique => true

  create_table "floors", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "plaza_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "plazas", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "location"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "customer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "slots", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "floor_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "vehicles", :force => true do |t|
    t.string   "vehicle_name"
    t.string   "badge_number"
    t.string   "organization"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "customer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
