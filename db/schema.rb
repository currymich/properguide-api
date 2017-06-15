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

ActiveRecord::Schema.define(version: 20170615002218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dentists", force: :cascade do |t|
    t.string   "name"
    t.string   "office_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address_city"
    t.string   "license_num"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "notes"
    t.decimal  "tax_rate",      precision: 12, scale: 5
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.decimal  "unit_price",  precision: 12, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price", precision: 12, scale: 3
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "unit_name"
    t.string   "image_url"
    t.string   "alt_image"
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",        precision: 12, scale: 3
    t.decimal  "tax",             precision: 12, scale: 3
    t.decimal  "shipping",        precision: 12, scale: 3
    t.decimal  "total",           precision: 12, scale: 3
    t.integer  "order_status_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "dentist_id"
    t.integer  "count"
    t.string   "patient_name"
    t.string   "dentist_name"
    t.string   "order_status"
    t.datetime "due_date"
    t.string   "instructions"
    t.index ["dentist_id"], name: "index_orders_on_dentist_id", using: :btree
    t.index ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 12, scale: 3
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "image_url"
    t.boolean  "active"
    t.string   "alt_image"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "subject"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
    t.string   "email"
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.integer  "dentist_id"
    t.index ["dentist_id"], name: "index_users_on_dentist_id", using: :btree
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "dentists"
  add_foreign_key "orders", "order_statuses"
end
