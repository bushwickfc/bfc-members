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

ActiveRecord::Schema.define(version: 20140709031218) do

  create_table "committees", force: true do |t|
    t.integer  "member_id",  null: false
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "committees", ["member_id"], name: "index_committees_on_member_id", using: :btree
  add_index "committees", ["name"], name: "index_committees_on_name", unique: true, using: :btree

  create_table "fees", force: true do |t|
    t.integer  "member_id"
    t.integer  "receiver_id"
    t.float    "amount",         limit: 24, null: false
    t.date     "payment_date",              null: false
    t.string   "payment_type",              null: false
    t.string   "payment_method",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fees", ["member_id"], name: "index_fees_on_member_id", using: :btree
  add_index "fees", ["payment_date"], name: "index_fees_on_payment_date", using: :btree
  add_index "fees", ["receiver_id"], name: "index_fees_on_receiver_id", using: :btree

  create_table "members", force: true do |t|
    t.string   "first_name",                                           null: false
    t.string   "middle_name"
    t.string   "last_name",                                            null: false
    t.string   "email",                                                null: false
    t.string   "phone"
    t.string   "phone2"
    t.string   "fax"
    t.string   "address"
    t.string   "address2"
    t.string   "city",                            default: "Brooklyn"
    t.string   "state",                           default: "NY"
    t.string   "country",                         default: "US"
    t.string   "zip"
    t.string   "contact_preference",              default: "email"
    t.string   "gender"
    t.string   "status"
    t.date     "join_date",                                            null: false
    t.date     "date_of_birth"
    t.date     "on_hold_until"
    t.boolean  "admin",                           default: false
    t.boolean  "membership_agreement",            default: false
    t.float    "monthly_hours",        limit: 24, default: 4.0
    t.float    "membership_discount",  limit: 24, default: 0.0
    t.float    "investment_discount",  limit: 24, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["first_name", "middle_name", "last_name"], name: "index_members_on_first_name_and_middle_name_and_last_name", unique: true, using: :btree

  create_table "notes", force: true do |t|
    t.integer  "member_id"
    t.integer  "receiver_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["member_id"], name: "index_notes_on_member_id", using: :btree
  add_index "notes", ["receiver_id"], name: "index_notes_on_receiver_id", using: :btree

  create_table "time_banks", force: true do |t|
    t.integer  "member_id"
    t.integer  "admin_id"
    t.integer  "committee_id"
    t.datetime "start",                        null: false
    t.datetime "finish",                       null: false
    t.string   "time_type",                    null: false
    t.boolean  "approved",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_banks", ["admin_id"], name: "index_time_banks_on_admin_id", using: :btree
  add_index "time_banks", ["committee_id"], name: "index_time_banks_on_committee_id", using: :btree
  add_index "time_banks", ["member_id"], name: "index_time_banks_on_member_id", using: :btree

end