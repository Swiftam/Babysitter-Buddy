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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110213184807) do

  create_table "contacts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "number"
  end

  create_table "dependents", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "age"
    t.text     "medications"
    t.text     "sleep_schedule"
    t.text     "food_schedule"
    t.text     "homework_schedule"
    t.text     "entertainment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "house_rules"
    t.text     "babysitter_rules"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
