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

ActiveRecord::Schema.define(version: 20180218204804) do

  create_table "groups", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "description", limit: 300
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id"
    t.index ["group_id"], name: "index_groups_users_on_group_id"
    t.index ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id"
    t.index ["user_id"], name: "index_groups_users_on_user_id"
  end

  create_table "list_items", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.string "description", limit: 100, null: false
    t.string "comments", limit: 300
    t.string "site_link", limit: 100
    t.integer "quantity", default: 1, null: false
    t.integer "purchased", default: 0, null: false
    t.index ["list_id"], name: "index_list_items_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.string "name", limit: 100, null: false
    t.string "description", limit: 300
    t.index ["group_id"], name: "index_lists_on_group_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_hash", limit: 32, null: false
    t.string "password_hash", limit: 32, null: false
    t.string "first_name", limit: 32
    t.string "last_name", limit: 32
  end

  add_foreign_key "groups_users", "groups"
  add_foreign_key "groups_users", "users"
  add_foreign_key "list_items", "lists"
  add_foreign_key "lists", "groups"
  add_foreign_key "lists", "users"
end
