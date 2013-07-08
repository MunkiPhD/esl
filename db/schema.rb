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

ActiveRecord::Schema.define(version: 20130707053501) do

  create_table "circles", force: true do |t|
    t.string   "name",                       null: false
    t.string   "motto",       default: ""
    t.text     "description", default: "",   null: false
    t.boolean  "is_public",   default: true, null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "circles", ["user_id"], name: "index_circles_on_user_id", using: :btree

  create_table "exercises", force: true do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", force: true do |t|
    t.string   "name",                          default: ""
    t.string   "brand",                         default: ""
    t.string   "ndb_no",              limit: 6, default: ""
    t.text     "ingredients",                   default: ""
    t.boolean  "usda",                          default: false
    t.string   "serving_size",                  default: "1 serving", null: false
    t.integer  "calories",                      default: 0,           null: false
    t.integer  "calories_from_fat",             default: 0,           null: false
    t.decimal  "total_fat",                     default: 0.0,         null: false
    t.decimal  "saturated_fat",                 default: 0.0,         null: false
    t.decimal  "trans_fat",                     default: 0.0,         null: false
    t.decimal  "polyunsaturated_fat",           default: 0.0,         null: false
    t.decimal  "monounsaturated_fat",           default: 0.0,         null: false
    t.decimal  "cholesterol",                   default: 0.0,         null: false
    t.decimal  "sodium",                        default: 0.0,         null: false
    t.decimal  "carbs",                         default: 0.0,         null: false
    t.decimal  "dietary_fiber",                 default: 0.0,         null: false
    t.decimal  "sugars",                        default: 0.0,         null: false
    t.decimal  "protein",                       default: 0.0,         null: false
    t.integer  "vitamin_a",                     default: 0,           null: false
    t.integer  "vitamin_c",                     default: 0,           null: false
    t.integer  "calcium",                       default: 0,           null: false
    t.integer  "iron",                          default: 0,           null: false
    t.integer  "vitamin_d",                     default: 0,           null: false
    t.integer  "vitamin_e",                     default: 0,           null: false
    t.integer  "vitamin_k",                     default: 0,           null: false
    t.integer  "thiamin",                       default: 0,           null: false
    t.integer  "riboflavin",                    default: 0,           null: false
    t.integer  "niacin",                        default: 0,           null: false
    t.integer  "vitamin_b6",                    default: 0,           null: false
    t.integer  "biotin",                        default: 0,           null: false
    t.integer  "pantothenic_acid",              default: 0,           null: false
    t.integer  "phosphorus",                    default: 0,           null: false
    t.integer  "iodine",                        default: 0,           null: false
    t.integer  "magnesium",                     default: 0,           null: false
    t.integer  "zinc",                          default: 0,           null: false
    t.integer  "selenium",                      default: 0,           null: false
    t.integer  "copper",                        default: 0,           null: false
    t.integer  "manganese",                     default: 0,           null: false
    t.integer  "chromium",                      default: 0,           null: false
    t.integer  "molybednum",                    default: 0,           null: false
    t.integer  "caffeine",                      default: 0,           null: false
    t.integer  "alcohol",                       default: 0,           null: false
    t.decimal  "potassium",                     default: 0.0,         null: false
    t.integer  "folic_acid",                    default: 0,           null: false
    t.decimal  "boron",                         default: 0.0,         null: false
    t.decimal  "decimal",                       default: 0.0,         null: false
    t.decimal  "cobalt",                        default: 0.0,         null: false
    t.decimal  "chloride",                      default: 0.0,         null: false
    t.decimal  "fluoride",                      default: 0.0,         null: false
    t.decimal  "acetic_acid",                   default: 0.0,         null: false
    t.decimal  "citric_acid",                   default: 0.0,         null: false
    t.decimal  "lactic_acid",                   default: 0.0,         null: false
    t.decimal  "malic_acid",                    default: 0.0,         null: false
    t.decimal  "choline",                       default: 0.0,         null: false
    t.decimal  "taurine",                       default: 0.0,         null: false
    t.decimal  "glutamine",                     default: 0.0,         null: false
    t.decimal  "creatine",                      default: 0.0,         null: false
    t.decimal  "sugar_alcohols",                default: 0.0,         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

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
    t.string   "username",                           default: "", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "workout_exercises", force: true do |t|
    t.integer "workout_id",  null: false
    t.integer "exercise_id", null: false
  end

  add_index "workout_exercises", ["exercise_id"], name: "index_workout_exercises_on_exercise_id", using: :btree
  add_index "workout_exercises", ["workout_id"], name: "index_workout_exercises_on_workout_id", using: :btree

  create_table "workout_sets", force: true do |t|
    t.integer  "set_number",                       null: false
    t.integer  "rep_count",                        null: false
    t.integer  "weight",                           null: false
    t.string   "notes",               default: "", null: false
    t.integer  "workout_exercise_id",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workouts", force: true do |t|
    t.string   "title",                       null: false
    t.date     "date_performed",              null: false
    t.text     "notes",          default: "", null: false
    t.integer  "user_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id", using: :btree

end
