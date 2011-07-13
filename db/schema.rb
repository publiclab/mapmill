# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110713114318) do

  create_table "images", :force => true do |t|
    t.integer  "hits",       :default => 0,  :null => false
    t.string   "filename",   :default => "", :null => false
    t.string   "path",       :default => "", :null => false
    t.integer  "points",     :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
  end

  create_table "participants", :force => true do |t|
    t.integer  "site_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "active",                                       :default => true
    t.decimal  "lat",          :precision => 20, :scale => 10, :default => 0.0
    t.decimal  "lon",          :precision => 20, :scale => 10, :default => 0.0
    t.decimal  "end_lat",      :precision => 20, :scale => 10, :default => 0.0
    t.decimal  "end_lon",      :precision => 20, :scale => 10, :default => 0.0
    t.datetime "capture_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
