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

ActiveRecord::Schema.define(version: 20140913172534) do

  create_table "images", force: true do |t|
    t.string   "url"
    t.string   "thumbnail"
    t.string   "status"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quality",    default: 0
  end

  add_index "images", ["site_id"], name: "index_images_on_site_id"

  create_table "sites", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.text     "description"
    t.float    "lat"
    t.float    "lon"
    t.date     "updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identity_url"
  end

end
