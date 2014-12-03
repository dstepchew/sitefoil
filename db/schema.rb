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

ActiveRecord::Schema.define(version: 20141203005008) do

  create_table "actions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "acts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "channels", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hits", force: true do |t|
    t.string   "ip"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.string   "browser"
    t.string   "language"
    t.string   "device_type"
    t.integer  "visitor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "referrer"
    t.text     "tag"
    t.integer  "site_id"
    t.string   "device"
    t.string   "os_name"
    t.boolean  "new_visitor"
    t.string   "url"
  end

  add_index "hits", ["site_id"], name: "index_hits_on_site_id"

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
    t.integer  "site_id",         limit: 255
    t.string   "trigger_id"
    t.string   "act_id"
    t.string   "trig_channel_id"
    t.string   "act_channel_id"
    t.text     "js"
    t.text     "wizard_json"
    t.boolean  "enabled",                     default: true
    t.datetime "hit_last_time"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "status"
    t.string   "checkout_url"
    t.string   "total_selector"
    t.string   "confirmation_url"
    t.text     "tag"
    t.string   "order_url"
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

  create_table "visitors", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
