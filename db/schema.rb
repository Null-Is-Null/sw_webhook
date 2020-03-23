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

ActiveRecord::Schema.define(version: 2020_03_23_164601) do

  create_table "tags", force: :cascade do |t|
    t.string "name", default: ""
    t.integer "count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tags_tickets", id: false, force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "ticket_id", null: false
    t.index ["ticket_id", "tag_id"], name: "index_tags_tickets_on_ticket_id_and_tag_id", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "user_id"
    t.string "title", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
