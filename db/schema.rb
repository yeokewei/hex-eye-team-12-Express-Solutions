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

ActiveRecord::Schema[7.0].define(version: 2022_08_02_130805) do
  create_table "all_services", force: :cascade do |t|
    t.text "category"
    t.integer "category_id"
    t.text "service_id"
    t.text "service"
    t.text "migratable"
    t.integer "count"
    t.text "details"
    t.integer "digital_time"
    t.integer "branch_time"
    t.text "service_image_link"
    t.text "service_alt_text"
    t.text "cat_image_link"
    t.text "cat_alt_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "deep_link"
  end

  create_table "branches", force: :cascade do |t|
    t.text "bank"
    t.text "branch_name"
    t.text "branch"
    t.text "sms_number"
    t.integer "wait_time"
  end

  create_table "predictions", force: :cascade do |t|
    t.text "branch_name"
    t.text "service"
    t.bigint "unixdate"
    t.datetime "date"
    t.float "prediction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.text "topic"
  end

end
