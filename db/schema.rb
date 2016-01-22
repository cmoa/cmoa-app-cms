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

ActiveRecord::Schema.define(version: 20160122191544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "artist_artworks", force: true do |t|
    t.string   "uuid"
    t.integer  "artist_id"
    t.integer  "artwork_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "exhibition_id"
  end

  create_table "artists", force: true do |t|
    t.string   "country"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exhibition_id"
    t.string   "uuid",          null: false
    t.datetime "deleted_at"
    t.string   "code"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "artworks", force: true do |t|
    t.integer  "exhibition_id"
    t.integer  "artist_id"
    t.string   "title"
    t.string   "code"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "uuid",          null: false
    t.datetime "deleted_at"
    t.integer  "location_id"
    t.string   "share_url"
    t.integer  "beacon_major"
    t.integer  "beacon_minor"
  end

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",       null: false
    t.datetime "deleted_at"
  end

  create_table "exhibitions", force: true do |t|
    t.string   "title"
    t.string   "subtitle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",                                   null: false
    t.datetime "deleted_at"
    t.boolean  "is_live",                default: false
    t.integer  "position"
    t.string   "bg_iphone_file_name"
    t.string   "bg_iphone_content_type"
    t.integer  "bg_iphone_file_size"
    t.datetime "bg_iphone_updated_at"
    t.string   "bg_ipad_file_name"
    t.string   "bg_ipad_content_type"
    t.integer  "bg_ipad_file_size"
    t.datetime "bg_ipad_updated_at"
    t.string   "sponsor"
  end

  create_table "hours", force: true do |t|
    t.integer  "hours_id"
    t.datetime "start_schedule"
    t.datetime "end_schedule"
    t.time     "sunday_start"
    t.time     "sunday_end"
    t.binary   "sunday_isopen"
    t.time     "monday_start"
    t.time     "monday_end"
    t.binary   "monday_isopen"
    t.time     "tuesday_start"
    t.time     "tuesday_end"
    t.binary   "tuesday_isopen"
    t.time     "wednesday_start"
    t.time     "wednesday_end"
    t.binary   "wednesday_isopen"
    t.time     "thursday_start"
    t.time     "thursday_end"
    t.binary   "thursday_isopen"
    t.time     "friday_start"
    t.time     "friday_end"
    t.binary   "friday_isopen"
    t.time     "saturday_start"
    t.time     "saturday_end"
    t.binary   "saturday_isopen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "exhibition_id"
    t.integer  "artwork_id"
    t.string   "device"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", force: true do |t|
    t.string   "uuid"
    t.integer  "artist_id"
    t.integer  "exhibition_id"
    t.string   "title"
    t.string   "url"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",      default: 0, null: false
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.string   "uuid",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "beacon_major"
    t.integer  "beacon_minor"
  end

  create_table "media", force: true do |t|
    t.integer  "exhibition_id"
    t.integer  "artwork_id"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",              null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "title"
    t.integer  "width"
    t.integer  "height"
    t.datetime "deleted_at"
    t.integer  "position"
  end

  create_table "tour_artworks", force: true do |t|
    t.integer  "tour_id"
    t.integer  "artwork_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "uuid",          null: false
    t.integer  "exhibition_id"
  end

  create_table "tours", force: true do |t|
    t.integer  "exhibition_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uuid",          null: false
    t.datetime "deleted_at"
    t.integer  "position"
    t.string   "subtitle"
  end

end
