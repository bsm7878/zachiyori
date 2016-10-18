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

ActiveRecord::Schema.define(version: 20161002145857) do

  create_table "accesses", force: :cascade do |t|
    t.string   "access_email"
    t.integer  "access_step"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "mart_id"
    t.string   "ok_address"
    t.integer  "together_zone"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "boxes", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "source_box"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "howtos", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "howto_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "ingredient_name"
    t.integer  "ingredient_price"
    t.string   "ingredient_amount"
    t.string   "ingredient_country"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "marts", force: :cascade do |t|
    t.string   "mart_name"
    t.string   "mart_email"
    t.string   "mart_img"
    t.string   "mart_leader"
    t.string   "mart_number"
    t.string   "agreement_day"
    t.string   "mart_address"
    t.string   "mart_time"
    t.string   "mart_phone"
    t.string   "mart_img1"
    t.string   "mart_img2"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "menus", force: :cascade do |t|
    t.integer  "mart_id"
    t.string   "menu_name"
    t.string   "menu_say"
    t.boolean  "menu_choice"
    t.string   "menu_img1"
    t.string   "menu_img2"
    t.string   "menu_img3"
    t.string   "menu_img4"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "privacies", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.string   "public_pw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provides", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "recipe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "user_id"
    t.string   "imp_uid"
    t.string   "deliver_time"
    t.integer  "total_price"
    t.string   "want_content"
    t.string   "credit_method"
    t.integer  "together_zone"
    t.boolean  "option_1"
    t.boolean  "option_2"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "readies", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "ready"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sources", force: :cascade do |t|
    t.integer  "menu_id"
    t.string   "source_name"
    t.string   "source_amount"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "address",                default: "", null: false
    t.string   "sub_address",            default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
