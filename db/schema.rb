# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_04_203218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rockets", force: :cascade do |t|
    t.string "reference_number", null: false, unique: true
    t.string "name", null: false
    t.string "type", null: false
    t.boolean "has_reused_core", null: false
  end

  create_table "flights", force: :cascade do |t|
    t.bigint "reference_number", null: false, unique: true
    t.text "details", null: false
    t.boolean "launch_successful", null: false
    t.datetime "local_launched_at", null: false
    t.json "links", null: false
    t.bigint "rocket_id", null: false
    t.index ["rocket_id"], name: "index_flights_on_rocket_id"
  end

  add_foreign_key "flights", "rockets"
end
