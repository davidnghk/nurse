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

ActiveRecord::Schema.define(version: 20161006010533) do

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.datetime "order_datetime"
    t.integer  "hours",                 limit: 4
    t.integer  "hospital",              limit: 4
    t.string   "location",              limit: 255
    t.integer  "fee",                   limit: 4
    t.integer  "cost",                  limit: 4
    t.string   "contact_person",        limit: 255
    t.integer  "contact_phone_no",      limit: 4
    t.string   "payment_token",         limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "nurse_id",              limit: 4
    t.integer  "status",                limit: 4
    t.integer  "payment",               limit: 4,   default: 0
    t.integer  "preferred_language",    limit: 4,   default: 0
    t.string   "notes",                 limit: 255
    t.datetime "cancellation_datetime"
    t.integer  "refund_amount",         limit: 4,   default: 0
    t.boolean  "refunded",                          default: false
    t.datetime "payment_datetime"
  end

  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "charges", force: :cascade do |t|
    t.datetime "charge_datetime"
    t.integer  "booking_id",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "charges", ["booking_id"], name: "index_charges_on_booking_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.string   "chi_name",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "devices", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "chi_name",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "chi_name",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "store_id",                 limit: 4,   null: false
    t.datetime "call_date",                            null: false
    t.date     "repair_date",                          null: false
    t.integer  "status",                   limit: 4,   null: false
    t.integer  "technician_id",            limit: 4,   null: false
    t.integer  "device_id",                limit: 4,   null: false
    t.integer  "issue_id",                 limit: 4,   null: false
    t.integer  "work_id",                  limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "photo_file_name",          limit: 255
    t.string   "photo_content_type",       limit: 255
    t.integer  "photo_file_size",          limit: 4
    t.datetime "photo_updated_at"
    t.string   "user_ref",                 limit: 255
    t.datetime "acknowledgement_datetime"
    t.datetime "call_datetime"
    t.string   "photo_02_file_name",       limit: 255
    t.string   "photo_02_content_type",    limit: 255
    t.integer  "photo_02_file_size",       limit: 4
    t.datetime "photo_02_updated_at"
    t.string   "photo_03_file_name",       limit: 255
    t.string   "photo_03_content_type",    limit: 255
    t.integer  "photo_03_file_size",       limit: 4
    t.datetime "photo_03_updated_at"
    t.string   "photo_04_file_name",       limit: 255
    t.string   "photo_04_content_type",    limit: 255
    t.integer  "photo_04_file_size",       limit: 4
    t.datetime "photo_04_updated_at"
    t.string   "photo_05_file_name",       limit: 255
    t.string   "photo_05_content_type",    limit: 255
    t.integer  "photo_05_file_size",       limit: 4
    t.datetime "photo_05_updated_at"
    t.string   "document_01_file_name",    limit: 255
    t.string   "document_01_content_type", limit: 255
    t.integer  "document_01_file_size",    limit: 4
    t.datetime "document_01_updated_at"
    t.string   "document_02_file_name",    limit: 255
    t.string   "document_02_content_type", limit: 255
    t.integer  "document_02_file_size",    limit: 4
    t.datetime "document_02_updated_at"
    t.string   "document_03_file_name",    limit: 255
    t.string   "document_03_content_type", limit: 255
    t.integer  "document_03_file_size",    limit: 4
    t.datetime "document_03_updated_at"
    t.string   "document_04_file_name",    limit: 255
    t.string   "document_04_content_type", limit: 255
    t.integer  "document_04_file_size",    limit: 4
    t.datetime "document_04_updated_at"
    t.string   "document_05_file_name",    limit: 255
    t.string   "document_05_content_type", limit: 255
    t.integer  "document_05_file_size",    limit: 4
    t.datetime "document_05_updated_at"
    t.string   "notes",                    limit: 255
  end

  add_index "orders", ["device_id"], name: "index_orders_on_device_id", using: :btree
  add_index "orders", ["issue_id"], name: "index_orders_on_issue_id", using: :btree
  add_index "orders", ["store_id"], name: "index_orders_on_store_id", using: :btree
  add_index "orders", ["work_id"], name: "index_orders_on_work_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.integer  "client_id",   limit: 4
    t.string   "code",        limit: 255
    t.string   "name",        limit: 255
    t.string   "chi_name",    limit: 255
    t.string   "address",     limit: 255
    t.string   "chi_address", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "phone_no",    limit: 4
    t.string   "device_01",   limit: 255
    t.string   "device_02",   limit: 255
    t.string   "device_03",   limit: 255
    t.string   "device_04",   limit: 255
  end

  add_index "stores", ["client_id"], name: "fk_client_idx", using: :btree

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
    t.integer  "bank_account_no",                limit: 8
    t.string   "bank_account_name",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "works", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "chi_name",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "bookings", "users"
  add_foreign_key "charges", "bookings"
  add_foreign_key "orders", "devices"
  add_foreign_key "orders", "issues"
  add_foreign_key "orders", "stores"
  add_foreign_key "orders", "works"
  add_foreign_key "stores", "clients", name: "fk_client"
end
