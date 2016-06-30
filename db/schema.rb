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

ActiveRecord::Schema.define(version: 20160630083246) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id",            limit: 4
    t.datetime "order_datetime"
    t.integer  "hours",              limit: 4
    t.integer  "hospital",           limit: 4
    t.string   "location",           limit: 255
    t.integer  "fee",                limit: 4
    t.integer  "cost",               limit: 4
    t.string   "contact_person",     limit: 255
    t.integer  "contact_phone_no",   limit: 4
    t.string   "payment_token",      limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "nurse_id",           limit: 4
    t.integer  "status",             limit: 4
    t.integer  "payment",            limit: 4,   default: 0
    t.integer  "preferred_language", limit: 4,   default: 0
    t.string   "notes",              limit: 255
  end

  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.datetime "datetime"
    t.integer  "duration",              limit: 4
    t.integer  "hospital",              limit: 4
    t.string   "location",              limit: 255
    t.integer  "server_grade",          limit: 4
    t.integer  "server_id",             limit: 4
    t.string   "contact_person",        limit: 255
    t.integer  "contact_phone_no",      limit: 4
    t.integer  "fee",                   limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "aasm_state",            limit: 255
    t.date     "booking_date"
    t.time     "booking_time"
    t.datetime "booking_datetime"
    t.string   "stripe_card_token",     limit: 255
    t.string   "stripe_customer_token", limit: 255
    t.string   "stripe_charge_token",   limit: 255
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "token",      limit: 255
    t.integer  "order_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_servers", force: :cascade do |t|
    t.string   "profession_status", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                          limit: 255,                          default: "",  null: false
    t.string   "encrypted_password",             limit: 255,                          default: "",  null: false
    t.string   "reset_password_token",           limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                  limit: 4,                            default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",             limit: 255
    t.string   "last_sign_in_ip",                limit: 255
    t.datetime "created_at",                                                                        null: false
    t.datetime "updated_at",                                                                        null: false
    t.string   "name",                           limit: 255
    t.string   "confirmation_token",             limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",              limit: 255
    t.integer  "role",                           limit: 4
    t.string   "invitation_token",               limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit",               limit: 4
    t.integer  "invited_by_id",                  limit: 4
    t.string   "invited_by_type",                limit: 255
    t.integer  "invitations_count",              limit: 4,                            default: 0
    t.integer  "qualification",                  limit: 4
    t.string   "registration_no",                limit: 255
    t.string   "registration_chinese_name",      limit: 255
    t.string   "registration_english_name",      limit: 255
    t.date     "registration_expiry_date"
    t.string   "aasm_state",                     limit: 255
    t.string   "image_file_name",                limit: 255
    t.string   "image_content_type",             limit: 255
    t.integer  "image_file_size",                limit: 4
    t.datetime "image_updated_at"
    t.string   "hkid_image_file_name",           limit: 255
    t.string   "hkid_image_content_type",        limit: 255
    t.integer  "hkid_image_file_size",           limit: 4
    t.datetime "hkid_image_updated_at"
    t.string   "certificate_image_file_name",    limit: 255
    t.string   "certificate_image_content_type", limit: 255
    t.integer  "certificate_image_file_size",    limit: 4
    t.datetime "certificate_image_updated_at"
    t.integer  "phone_no",                       limit: 4
    t.decimal  "rating",                                     precision: 10, scale: 2, default: 5.0
    t.integer  "status",                         limit: 4
    t.integer  "bank",                           limit: 4
    t.integer  "bank_account_no",                limit: 4
    t.string   "bank_account_name",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bookings", "users"
  add_foreign_key "orders", "users"
end
