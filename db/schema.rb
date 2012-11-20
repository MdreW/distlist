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

ActiveRecord::Schema.define(:version => 20121008071018) do

  create_table "addresses", :force => true do |t|
    t.integer  "campaign_id",               :default => 0,     :null => false
    t.string   "email",                     :default => "",    :null => false
    t.string   "name"
    t.string   "surname"
    t.string   "pepper",      :limit => 25, :default => "",    :null => false
    t.integer  "fail_count",                :default => 0,     :null => false
    t.boolean  "inactive",                  :default => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "addresses", ["campaign_id"], :name => "index_addresses_on_campaign_id"
  add_index "addresses", ["email"], :name => "index_addresses_on_email"
  add_index "addresses", ["pepper"], :name => "index_addresses_on_pepper", :unique => true

  create_table "attachments", :force => true do |t|
    t.integer  "email_id",                                  :null => false
    t.string   "atype",             :default => "attached", :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "attachments", ["atype"], :name => "index_attachments_on_atype"
  add_index "attachments", ["email_id"], :name => "index_attachments_on_email_id"

  create_table "campaigns", :force => true do |t|
    t.integer  "user_id",                      :null => false
    t.string   "title",        :default => "", :null => false
    t.text     "header"
    t.text     "footer"
    t.string   "sender_name"
    t.string   "sender_email", :default => "", :null => false
    t.integer  "time_gap",     :default => 0,  :null => false
    t.boolean  "unsubscribe"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "campaigns", ["user_id"], :name => "index_campaigns_on_user_id"

  create_table "emails", :force => true do |t|
    t.integer  "campaign_id",                     :null => false
    t.string   "subject",      :default => "",    :null => false
    t.text     "body"
    t.boolean  "sended",       :default => false
    t.string   "key_required", :default => "",    :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "emails", ["campaign_id"], :name => "index_emails_on_campaign_id"
  add_index "emails", ["sended"], :name => "index_emails_on_sended"

  create_table "logs", :force => true do |t|
    t.integer  "email_id",    :null => false
    t.integer  "email_count", :null => false
    t.integer  "row_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "logs", ["email_id"], :name => "index_logs_on_email_id"

  create_table "options", :force => true do |t|
    t.integer  "address_id"
    t.string   "key",        :default => "", :null => false
    t.string   "value"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "options", ["address_id"], :name => "index_options_on_address_id"
  add_index "options", ["key"], :name => "index_options_on_key"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        :default => 0
    t.datetime "locked_at"
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
