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

ActiveRecord::Schema.define(version: 20160615040019) do

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "datetime"
    t.integer  "duration"
    t.integer  "hospital"
    t.string   "location"
    t.integer  "server_grade"
    t.integer  "server_id"
    t.string   "contact_person"
    t.integer  "contact_phone_no"
    t.integer  "fee"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "aasm_state"
    t.date     "booking_date"
    t.time     "booking_time"
    t.datetime "booking_datetime"
    t.string   "stripe_card_token"
    t.string   "stripe_customer_token"
    t.string   "stripe_charge_token"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "payments", force: :cascade do |t|
    t.string   "email"
    t.string   "token"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_servers", force: :cascade do |t|
    t.string   "profession_status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                   default: "",  null: false
    t.string   "encrypted_password",                                      default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                           default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",                                       default: 0
    t.integer  "qualification"
    t.string   "registration_no"
    t.string   "registration_chinese_name"
    t.string   "registration_english_name"
    t.date     "registration_expiry_date"
    t.string   "aasm_state"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "hkid_image_file_name"
    t.string   "hkid_image_content_type"
    t.integer  "hkid_image_file_size"
    t.datetime "hkid_image_updated_at"
    t.string   "certificate_image_file_name"
    t.string   "certificate_image_content_type"
    t.integer  "certificate_image_file_size"
    t.datetime "certificate_image_updated_at"
    t.integer  "phone_no"
    t.decimal  "rating",                         precision: 10, scale: 2, default: 5.0
    t.integer  "status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
