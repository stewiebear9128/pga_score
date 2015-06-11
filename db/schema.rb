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

ActiveRecord::Schema.define(version: 20150611161711) do

  create_table "entries", force: :cascade do |t|
    t.integer  "pool_owner"
    t.float    "current_payoff"
    t.integer  "current_place"
    t.integer  "golfer_flex"
    t.integer  "golfer_d"
    t.integer  "golfer_c"
    t.integer  "golfer_b"
    t.integer  "golfer_a"
    t.integer  "pool_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "golfer_results", force: :cascade do |t|
    t.float    "current_payout"
    t.float    "total_score"
    t.integer  "current_place"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reg_id"
    t.string   "status"
    t.integer  "tournament_id"
  end

  create_table "golfers", force: :cascade do |t|
    t.string   "picture"
    t.string   "name"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lastname"
    t.integer  "height"
    t.integer  "weight"
    t.date     "birthday"
    t.string   "country"
    t.string   "college"
    t.string   "birthplace"
    t.integer  "turned_pro"
  end

  create_table "payoffs", force: :cascade do |t|
    t.float    "payout"
    t.integer  "place"
    t.string   "tournament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pools", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "owner_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "tournament_id"
    t.integer  "golfer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flight"
    t.integer  "wg_ranking"
  end

  create_table "tournaments", force: :cascade do |t|
    t.datetime "start_time"
    t.string   "key"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "end_date"
    t.float    "purse"
    t.string   "venue_name"
    t.string   "venue_city"
    t.string   "venue_state"
    t.float    "winning_share"
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "role"
    t.string   "userid"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
