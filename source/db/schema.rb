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

ActiveRecord::Schema[7.2].define(version: 2024_10_08_225310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_participants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_participants_on_event_id"
    t.index ["user_id", "event_id"], name: "index_event_participants_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_event_participants_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "organiser_id"
    t.datetime "start"
    t.datetime "end"
    t.integer "participants_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "event_participants", "events"
  add_foreign_key "event_participants", "users"
end
