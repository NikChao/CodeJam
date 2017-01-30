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

ActiveRecord::Schema.define(version: 20170130063951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "link"
    t.integer  "competition_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "points"
    t.string   "difficulty"
    t.string   "example"
    t.index ["competition_id"], name: "index_problems_on_competition_id", using: :btree
  end

  create_table "solutions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "problem_id"
    t.string   "language"
    t.text     "code"
    t.boolean  "validity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_solutions_on_problem_id", using: :btree
    t.index ["user_id"], name: "index_solutions_on_user_id", using: :btree
  end

  create_table "tests", force: :cascade do |t|
    t.text     "input",      default: [],              array: true
    t.text     "output"
    t.integer  "problem_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["problem_id"], name: "index_tests_on_problem_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password"
    t.string   "remember_digest"
    t.boolean  "admin"
  end

  add_foreign_key "problems", "competitions"
  add_foreign_key "solutions", "problems"
  add_foreign_key "solutions", "users"
  add_foreign_key "tests", "problems"
end
