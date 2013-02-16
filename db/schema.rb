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

ActiveRecord::Schema.define(:version => 20130207222240) do

  create_table "expenses", :force => true do |t|
    t.string   "name",                                                            :null => false
    t.decimal  "amount",         :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.integer  "wallet_id"
    t.date     "execution_date"
    t.integer  "family_id"
    t.integer  "user_id"
    t.boolean  "done",                                          :default => true
  end

  add_index "expenses", ["family_id"], :name => "index_expenses_on_family_id"
  add_index "expenses", ["user_id"], :name => "index_expenses_on_user_id"

  create_table "families", :force => true do |t|
    t.datetime "created_at"
  end

  create_table "families_users", :id => false, :force => true do |t|
    t.integer "family_id"
    t.integer "user_id"
  end

  create_table "incomes", :force => true do |t|
    t.string   "source",                                                    :null => false
    t.decimal  "amount",                      :precision => 8, :scale => 2
    t.integer  "tax",            :limit => 2
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.integer  "wallet_id"
    t.integer  "user_id"
    t.integer  "family_id"
    t.date     "execution_date"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "invited_by"
    t.string   "locale"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "wallets", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",                                                       :null => false
    t.decimal  "amount",     :precision => 10, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "family_id"
  end

end
