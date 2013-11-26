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

ActiveRecord::Schema.define(:version => 20131126152510) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "changes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "vehiclecapacity"
    t.integer  "floorcapacity"
    t.integer  "usercapacity"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "customer_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "designation"
    t.string   "phone"
    t.string   "cell"
    t.string   "email"
    t.integer  "customer_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "delflag",     :default => false
  end

  create_table "customers", :force => true do |t|
    t.string   "company_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "web"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "user_id"
    t.string   "city"
    t.boolean  "delflag",      :default => false
  end

  create_table "floors", :force => true do |t|
    t.string   "nickname"
    t.string   "description"
    t.string   "capacity"
    t.string   "occupied"
    t.integer  "location_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "delflag",     :default => false
  end

  create_table "locations", :force => true do |t|
    t.string   "nickname"
    t.string   "description"
    t.string   "address1"
    t.string   "address2"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "web"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "city"
    t.boolean  "delflag",     :default => false
  end

  create_table "logos", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "systemname"
    t.string   "companyname"
    t.text     "copytext"
  end

  create_table "organization_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "designation"
    t.string   "phone"
    t.string   "cell"
    t.string   "email"
    t.integer  "organization_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "delflag",         :default => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "company_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "web"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "city"
    t.boolean  "delflag",      :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "cell"
    t.string   "role"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "passwordhint"
    t.string   "employeeno"
    t.integer  "parent_id"
    t.integer  "customer_id"
    t.boolean  "pass_change",                           :default => false
    t.boolean  "delflag",                               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vehicle_histories", :force => true do |t|
    t.string   "slot"
    t.integer  "floor_id"
    t.integer  "location_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "platenumber"
  end

  create_table "vehicles", :force => true do |t|
    t.string   "platenumber"
    t.string   "driver_first_name"
    t.string   "driver_middle_name"
    t.string   "driver_last_name"
    t.date     "permit_date"
    t.date     "expiry_date"
    t.string   "badge_number"
    t.integer  "organization_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "visitor"
    t.boolean  "delflag",            :default => false
  end

end
