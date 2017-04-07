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

ActiveRecord::Schema.define(version: 20170405222856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.string   "price"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "neighborhood"
    t.string   "monday_hr"
    t.string   "tuesday_hr"
    t.string   "wednesday_hr"
    t.string   "thursday_hr"
    t.string   "friday_hr"
    t.string   "saturday_hr"
    t.string   "sunday_hr"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "monday_closing_hr"
    t.string   "tuesday_closing_hr"
    t.string   "wednesday_closing_hr"
    t.string   "thursday_closing_hr"
    t.string   "friday_closing_hr"
    t.string   "saturday_closing_hr"
    t.string   "sunday_closing_hr"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.string   "content"
    t.integer  "rating"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "full_name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
