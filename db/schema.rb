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

ActiveRecord::Schema.define(version: 20151006014128) do

  create_table "cached_pubtickers", force: :cascade do |t|
    t.string   "ticker_symbol_a",  limit: 255
    t.string   "ticker_symbol_b",  limit: 255
    t.float    "high",             limit: 24
    t.float    "low",              limit: 24
    t.float    "avg",              limit: 24
    t.string   "period_begin",     limit: 255
    t.string   "period_end",       limit: 255
    t.integer  "timeperiod",       limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.float    "open",             limit: 24
    t.float    "close",            limit: 24
    t.float    "delta",            limit: 24
    t.float    "delta_percentage", limit: 24
  end

  create_table "pubtickers", force: :cascade do |t|
    t.float    "mid",          limit: 24
    t.float    "bid",          limit: 24
    t.float    "ask",          limit: 24
    t.float    "last_price",   limit: 24
    t.float    "low",          limit: 24
    t.float    "high",         limit: 24
    t.float    "volume",       limit: 24
    t.string   "timestamp",    limit: 255
    t.string   "tickerSymbol", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
