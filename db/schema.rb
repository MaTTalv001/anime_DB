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

ActiveRecord::Schema[7.1].define(version: 2024_01_31_132405) do
  create_table "actors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "person_id", null: false
    t.string "name"
    t.string "name_en"
    t.string "official_site_url"
    t.string "twitter_url"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "casts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "work_id", null: false
    t.integer "cast_id", null: false
    t.integer "sort_number"
    t.integer "person_id", null: false
    t.string "character_name"
    t.string "character_name_kana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.integer "year"
    t.string "season"
    t.string "image_url"
    t.string "official_site_url"
    t.integer "annict_id"
    t.integer "syobocal_tid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title_kana", null: false
    t.string "twitter_url"
  end

end
