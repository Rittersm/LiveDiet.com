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

ActiveRecord::Schema.define(version: 20160816152355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_ins", force: :cascade do |t|
    t.integer  "weight"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "plan_id"
    t.index ["plan_id"], name: "index_check_ins_on_plan_id", using: :btree
    t.index ["user_id"], name: "index_check_ins_on_user_id", using: :btree
  end

  create_table "logs", force: :cascade do |t|
    t.text     "daily_overview"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "plan_id"
    t.index ["plan_id"], name: "index_logs_on_plan_id", using: :btree
    t.index ["user_id"], name: "index_logs_on_user_id", using: :btree
  end

  create_table "plans", force: :cascade do |t|
    t.text     "overview"
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.index ["user_id"], name: "index_plans_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.text     "expectations"
    t.integer  "starting_weight"
    t.integer  "user_id"
    t.integer  "plan_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "rating"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "starting_weight"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "feet"
    t.integer  "inches"
  end

  add_foreign_key "check_ins", "users"
  add_foreign_key "logs", "users"
  add_foreign_key "plans", "users"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
end
