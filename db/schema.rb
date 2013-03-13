# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130313013925) do

  create_table "exercises", force: true do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "workout_sets", force: true do |t|
    t.integer  "set_number",               null: false
    t.integer  "rep_count",                null: false
    t.integer  "weight",                   null: false
    t.string   "notes",       default: "", null: false
    t.integer  "workout_id",               null: false
    t.integer  "exercise_id",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workout_sets", ["exercise_id"], name: "index_workout_sets_on_exercise_id"
  add_index "workout_sets", ["workout_id"], name: "index_workout_sets_on_workout_id"

  create_table "workouts", force: true do |t|
    t.string   "title",                       null: false
    t.date     "date_performed",              null: false
    t.text     "notes",          default: "", null: false
    t.integer  "user_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id"

end
