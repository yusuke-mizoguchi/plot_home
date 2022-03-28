# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_11_145104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.bigint "novel_id", null: false
    t.text "character_text"
    t.string "character_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id"], name: "index_characters_on_novel_id"
  end

  create_table "novels", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.integer "genre", default: 0, null: false
    t.integer "story_length", default: 0, null: false
    t.text "plot", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "release", default: 0, null: false
    t.index ["user_id"], name: "index_novels_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "novel_id", null: false
    t.text "good_point", null: false
    t.text "bad_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["novel_id"], name: "index_reviews_on_novel_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "salt"
    t.boolean "admin", default: false, null: false
    t.integer "role", default: 0, null: false
    t.text "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "characters", "novels"
  add_foreign_key "novels", "users"
  add_foreign_key "reviews", "novels"
  add_foreign_key "reviews", "users"
end
