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

ActiveRecord::Schema.define(version: 20140603042255) do

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

  add_index "champions", ["user_id", "table_champion_id", "created_at"], name: "index_champions"

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
