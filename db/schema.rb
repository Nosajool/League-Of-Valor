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

ActiveRecord::Schema.define(version: 20140627143406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battle_logs", force: true do |t|
    t.integer  "battle_id"
    t.text     "event"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "battle_logs", ["battle_id"], name: "index_battle_logs_on_battle_id", using: :btree

  create_table "battles", force: true do |t|
    t.integer  "user_id"
    t.integer  "opp_id"
    t.integer  "champ1"
    t.integer  "champ2"
    t.integer  "champ3"
    t.integer  "champ4"
    t.integer  "champ5"
    t.integer  "champ6"
    t.integer  "champ7"
    t.integer  "champ8"
    t.integer  "champ9"
    t.integer  "champ10"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "probability"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  add_index "map_champions", ["map_id"], name: "index_map_champions_on_map_id", using: :btree

  create_table "maps", force: true do |t|
    t.string   "map_name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.float    "hp_base"
    t.float    "hp_per"
    t.float    "ad_base"
    t.float    "ad_per"
    t.float    "ap_base"
    t.float    "ap_per"
    t.float    "ar_base"
    t.float    "ar_per"
    t.float    "mr_base"
    t.float    "mr_per"
    t.float    "ms_base"
    t.float    "ms_per"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skins", force: true do |t|
    t.integer  "table_champion_id"
    t.integer  "num"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "table_champions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hp"
    t.integer  "attack_damage"
    t.integer  "armor"
    t.integer  "magic_resist"
    t.integer  "attack_range"
    t.integer  "riot_id"
    t.string   "key"
    t.text     "title"
    t.string   "f_role"
    t.string   "s_role"
    t.text     "lore"
    t.integer  "hp_per_level"
    t.float    "attack_damage_per_level"
    t.float    "armor_per_level"
    t.float    "magic_resist_per_level"
    t.integer  "movespeed"
  end

  add_index "table_champions", ["key"], name: "index_table_champions_on_key", unique: true, using: :btree

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
