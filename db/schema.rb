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

ActiveRecord::Schema[7.0].define(version: 2023_01_11_123616) do
  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "pull_request_id", null: false
    t.integer "score"
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pull_request_id"], name: "index_comments_on_pull_request_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "score"
    t.integer "state"
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pull_requests_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "pull_request_id", null: false
    t.integer "score"
    t.datetime "created", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pull_request_id"], name: "index_reviews_on_pull_request_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "pull_requests"
  add_foreign_key "comments", "users"
  add_foreign_key "pull_requests", "users"
  add_foreign_key "reviews", "pull_requests"
  add_foreign_key "reviews", "users"
end
