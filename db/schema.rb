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

ActiveRecord::Schema.define(version: 20180221162608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenities_apartments", id: false, force: :cascade do |t|
    t.integer "amenity_id", null: false
    t.integer "apartment_id", null: false
    t.index ["amenity_id", "apartment_id"], name: "index_amenities_apartments_on_amenity_id_and_apartment_id"
  end

  create_table "apartments", force: :cascade do |t|
    t.integer "building_id"
    t.string "apartment_type"
    t.string "apt_number"
    t.float "bathroom_count"
    t.integer "bedroom_count"
    t.integer "room_count"
    t.float "monthly_rate"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "apartments_bookings", id: false, force: :cascade do |t|
    t.integer "apartment_id", null: false
    t.integer "booking_id", null: false
    t.date "status_date"
    t.boolean "available"
    t.index ["apartment_id", "booking_id"], name: "index_apartments_bookings_on_apartment_id_and_booking_id"
    t.index ["booking_id", "apartment_id"], name: "index_apartments_bookings_on_booking_id_and_apartment_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "apartment_id"
    t.date "booking_start_date"
    t.date "booking_end_date"
    t.string "status"
    t.float "actual_monthly_rate"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings_guests", id: false, force: :cascade do |t|
    t.integer "booking_id", null: false
    t.integer "guest_id", null: false
  end

  create_table "building_amenities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "building_amenities_buildings", id: false, force: :cascade do |t|
    t.integer "building_id", null: false
    t.integer "building_amenity_id", null: false
    t.index ["building_amenity_id", "building_id"], name: "index_building_amenity_to_building"
    t.index ["building_id", "building_amenity_id"], name: "index_building_to_building_amenity"
  end

  create_table "buildings", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "street_address"
    t.string "city"
    t.integer "state_id"
    t.string "zip"
    t.string "manager_name"
    t.string "phone_number"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guests", force: :cascade do |t|
    t.string "gender"
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.string "email"
    t.string "phone_number"
    t.date "date_of_birth"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "abbreviation"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
