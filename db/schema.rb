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

ActiveRecord::Schema.define(version: 20170404121003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.date     "end_date"
    t.integer  "num_guests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "start_date"
    t.index ["listing_id"], name: "index_bookings_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.text     "description"
    t.integer  "max_guest"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.json     "images"
    t.index ["user_id"], name: "index_listings_on_user_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.integer "booking_id"
    t.string  "braintree_payment_id"
    t.string  "status"
    t.string  "fourdigit"
    t.index ["booking_id"], name: "index_payments_on_booking_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "email",                                      null: false
    t.string   "encrypted_password", limit: 128,             null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,             null: false
    t.integer  "role",                           default: 0
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "bookings", "users"
  add_foreign_key "listings", "users"
end
