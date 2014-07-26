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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140726213912) do

  create_table "actions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "channels", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "hits"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "site_id"
    t.string   "trigger_id"
    t.string   "act_id"
    t.string   "trig_channel_id"
    t.string   "act_channel_id"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "coupon_url"
    t.string   "coupon_id"
    t.string   "status"
    t.string   "checkout_url"
    t.string   "total_id"
    t.string   "confirmation_url"
  end

  add_index "sites", ["user_id"], name: "index_sites_on_user_id"

  create_table "triggers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "organization"
    t.string   "full_name"
    t.string   "role"
    t.string   "status",                 default: "Private"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["organization"], name: "index_users_on_organization"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
