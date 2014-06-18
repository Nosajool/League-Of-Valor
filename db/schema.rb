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

ActiveRecord::Schema.define(version: 20140617050750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "champions", force: true do |t|
    t.integer  "table_champion_id"
    t.integer  "experience"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "skin"
    t.integer  "active_skin"
    t.integer  "level"
  end

  add_index "champions", ["user_id", "table_champion_id", "created_at"], name: "index_champions", using: :btree

  create_table "map_champions", force: true do |t|
    t.integer  "map_id"
    t.integer  "champ_id"
    t.integer  "probability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "map_champions", ["map_id"], name: "index_map_champions_on_map_id", using: :btree

  create_table "maps", force: true do |t|
    t.string   "map_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "table_champions", force: true do |t|
    t.string   "champ_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "health"
    t.integer  "attack_damage"
    t.integer  "ability_power"
    t.integer  "armor"
    t.integer  "magic_resist"
    t.string   "role"
    t.integer  "catch_rate"
    t.integer  "range"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "duser"
    t.integer  "icon"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
