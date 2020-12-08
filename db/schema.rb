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

ActiveRecord::Schema.define(version: 2020_12_08_051132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rides", force: :cascade do |t|
    t.string "name", null: false
    t.string "status", default: "operational", null: false
    t.integer "capacity", null: false
    t.float "duration", null: false, comment: "duration is in minutes"
    t.string "sensor_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sensor_code"], name: "index_rides_on_sensor_code", unique: true
  end

  create_table "visitors", force: :cascade do |t|
    t.bigint "ride_id"
    t.integer "visitors_count", null: false
    t.datetime "collected_at", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.datetime "updated_at", default: -> { "now()" }, null: false
    t.index ["collected_at"], name: "index_visitors_on_collected_at"
    t.index ["ride_id", "visitors_count", "collected_at"], name: "index_visitors_on_ride_id_and_visitors_count_and_collected_at", unique: true
    t.index ["ride_id"], name: "index_visitors_on_ride_id"
  end

end
