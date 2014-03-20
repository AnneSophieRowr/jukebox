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

ActiveRecord::Schema.define(version: 20140318145647) do

  create_table "albums", force: true do |t|
    t.string   "name",       null: false
    t.string   "image"
    t.integer  "year"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums_songs", force: true do |t|
    t.integer  "album_id"
    t.integer  "song_id"
    t.integer  "position"
    t.datetime "updated_at"
  end

  create_table "artists", force: true do |t|
    t.string   "name",        null: false
    t.string   "image"
    t.text     "description"
    t.datetime "updated_at"
  end

  create_table "artists_songs", force: true do |t|
    t.integer  "artist_id"
    t.integer  "song_id"
    t.datetime "updated_at"
  end

  create_table "kinds", force: true do |t|
    t.string   "name",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.boolean  "visible",     default: false
    t.text     "description"
  end

  create_table "kinds_playlists", force: true do |t|
    t.integer  "kind_id"
    t.integer  "playlist_id"
    t.datetime "updated_at"
  end

  create_table "parameters", force: true do |t|
    t.string   "name",       null: false
    t.string   "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlists", force: true do |t|
    t.string   "name",        null: false
    t.string   "image"
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "playlists_songs", force: true do |t|
    t.integer  "playlist_id"
    t.integer  "song_id"
    t.integer  "position"
    t.datetime "updated_at"
  end

  create_table "playlists_types", force: true do |t|
    t.integer  "playlist_id"
    t.integer  "type_id"
    t.datetime "updated_at"
  end

  create_table "records", force: true do |t|
    t.integer  "recordable_id",   null: false
    t.string   "recordable_type", null: false
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at"
  end

  create_table "songs", force: true do |t|
    t.string   "name",       null: false
    t.string   "image"
    t.string   "file"
    t.integer  "duration"
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
  end

  create_table "types", force: true do |t|
    t.string   "name",       null: false
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",              default: "", null: false
    t.string   "last_name",                       null: false
    t.string   "first_name",                      null: false
    t.string   "encrypted_password", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
