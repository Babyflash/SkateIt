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

ActiveRecord::Schema.define(version: 2019_04_17_163201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checkins", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_checkins_on_spot_id"
    t.index ["user_id"], name: "index_checkins_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.string "spot_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "geo_tag_longitude"
    t.string "geo_tag_latitude"
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_locations_on_spot_id"
  end

  create_table "post_contents", force: :cascade do |t|
    t.string "media_url"
    t.string "media_geotag_longitude"
    t.string "media_geotag_latitude"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_contents_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "description"
    t.integer "likes"
    t.string "hash_tag"
    t.bigint "user_id"
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_posts_on_spot_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "spot_content", force: :cascade do |t|
    t.string "media_url"
    t.string "media_geotag_longitude"
    t.string "media_geotag_latitude"
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_spot_content_on_spot_id"
  end

  create_table "spots", force: :cascade do |t|
    t.integer "spot_rating"
    t.integer "difficulty_rating"
    t.string "type"
    t.string "default_image"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "checkins", "spots"
  add_foreign_key "checkins", "users"
  add_foreign_key "favorites", "users"
  add_foreign_key "locations", "spots"
  add_foreign_key "post_contents", "posts"
  add_foreign_key "posts", "spots"
  add_foreign_key "posts", "users"
  add_foreign_key "spot_content", "spots"
  add_foreign_key "spots", "users"
end
