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

ActiveRecord::Schema.define(version: 20171118173647) do

  create_table "locations", force: :cascade do |t|
    t.decimal "longitude"
    t.decimal "latitude"
    t.integer "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_locations_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "status"
    t.integer "startpoint_id"
    t.integer "endpoint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endpoint_id"], name: "index_trips_on_endpoint_id"
    t.index ["startpoint_id"], name: "index_trips_on_startpoint_id"
  end

end
