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

ActiveRecord::Schema.define(version: 20150909003425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.text     "name"
    t.text     "pen_name"
    t.date     "dob"
    t.date     "dod"
    t.text     "nationality"
    t.text     "image"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "good_reads_author_id"
  end

  create_table "books", force: :cascade do |t|
    t.text     "title"
    t.text     "publisher"
    t.text     "year"
    t.text     "image"
    t.text     "isbn"
    t.text     "description"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books_genres", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "genre_id"
  end

  create_table "genres", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "readings", force: :cascade do |t|
    t.integer  "status",     default: 1
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "description"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "name"
    t.text     "image"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "password_digest"
    t.boolean  "admin",           default: false
  end

end
