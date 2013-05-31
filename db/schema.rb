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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130531101154) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.datetime "release_time"
    t.integer  "singer_id"
    t.boolean  "is_new",                :default => false
    t.integer  "hot_album_category_id"
    t.text     "description"
    t.string   "link"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "albums", ["hot_album_category_id"], :name => "index_albums_on_hot_album_category_id"
  add_index "albums", ["link"], :name => "index_albums_on_link"
  add_index "albums", ["name"], :name => "index_albums_on_name"
  add_index "albums", ["singer_id"], :name => "index_albums_on_singer_id"

  create_table "hot_album_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hot_album_ships", :force => true do |t|
    t.integer  "album_id"
    t.integer  "hot_album_category_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "hot_album_ships", ["album_id"], :name => "index_hot_album_ships_on_album_id"
  add_index "hot_album_ships", ["hot_album_category_id"], :name => "index_hot_album_ships_on_hot_album_category_id"

  create_table "hot_song_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hot_song_ships", :force => true do |t|
    t.integer  "song_id"
    t.integer  "hot_song_category_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "hot_song_ships", ["hot_song_category_id"], :name => "index_hot_song_ships_on_hot_song_category_id"
  add_index "hot_song_ships", ["song_id"], :name => "index_hot_song_ships_on_song_id"

  create_table "singer_categories", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "singer_search_way_item_relations", :force => true do |t|
    t.integer  "singer_id"
    t.integer  "singer_search_way_item_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "singer_search_way_items", :force => true do |t|
    t.integer  "singer_search_way_id"
    t.string   "name"
    t.string   "link"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "singer_search_ways", :force => true do |t|
    t.integer  "singer_category_id"
    t.string   "name"
    t.string   "link"
    t.integer  "order"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "singers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "singer_category_id"
    t.boolean  "is_hot",             :default => false
    t.string   "link"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "singers", ["link"], :name => "index_singers_on_link"
  add_index "singers", ["name"], :name => "index_singers_on_name"
  add_index "singers", ["singer_category_id"], :name => "index_singers_on_singer_category_id"

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.integer  "album_id"
    t.integer  "singer_id"
    t.integer  "hot_song_category_id"
    t.string   "link"
    t.text     "lyric"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "songs", ["album_id"], :name => "index_songs_on_album_id"
  add_index "songs", ["hot_song_category_id"], :name => "index_songs_on_hot_song_category_id"
  add_index "songs", ["link"], :name => "index_songs_on_link"
  add_index "songs", ["name"], :name => "index_songs_on_name"
  add_index "songs", ["singer_id"], :name => "index_songs_on_singer_id"

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "youtube_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
