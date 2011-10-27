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

ActiveRecord::Schema.define(:version => 20111027030234) do

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "homepage",   :default => 0
  end

  create_table "tags_videos", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "video_id"
  end

  create_table "videos", :force => true do |t|
    t.text     "description"
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "youtube_id"
    t.string   "thumbnail_url"
    t.text     "embed_html"
    t.string   "big_thumbnail_url"
    t.integer  "views"
  end

end
