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

ActiveRecord::Schema.define(:version => 17) do

  create_table "accounts", :force => true do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "crypted_password"
    t.string "role"
  end

  create_table "people", :force => true do |t|
    t.string "name"
    t.string "pic"
    t.string "yaml"
  end

  create_table "speakers", :force => true do |t|
    t.integer "talk_id"
    t.integer "person_id"
  end

  create_table "sponsors", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "logo"
    t.string "website"
  end

  create_table "sponsorships", :force => true do |t|
    t.string "talk_id"
    t.string "sponsor_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer "talk_id"
    t.integer "person_id"
    t.integer "tag_id"
  end

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "talks", :force => true do |t|
    t.string "title"
    t.date   "date"
    t.string "s_descrip"
    t.string "l_descrip"
    t.string "thumb"
    t.string "video"
    t.string "slides"
  end

end
