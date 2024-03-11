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

ActiveRecord::Schema[7.1].define(version: 2024_02_15_032704) do
  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.string "credit_card_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.decimal "ticket_price"
    t.integer "seats_left"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id", null: false
    t.index ["room_id"], name: "index_events_on_room_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "feedback"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.index ["event_id"], name: "index_reviews_on_event_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "location"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "confirmation_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.integer "room_id", null: false
    t.integer "number_of_tickets"
    t.integer "price"
    t.decimal "total_price"
    t.integer "purchased_for_user_id"
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["purchased_for_user_id"], name: "index_tickets_on_purchased_for_user_id"
    t.index ["room_id"], name: "index_tickets_on_room_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.string "credit_card_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "admins", "users"
  add_foreign_key "events", "rooms"
  add_foreign_key "reviews", "events"
  add_foreign_key "reviews", "users"
  add_foreign_key "tickets", "events"
  add_foreign_key "tickets", "rooms"
  add_foreign_key "tickets", "users"
end
