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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120531102454) do

  create_table "answers", :force => true do |t|
    t.text     "description"
    t.boolean  "correct",     :default => false
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["course_id"], :name => "index_answers_on_course_id"
  add_index "answers", ["post_id"], :name => "index_answers_on_post_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "attachments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "courses", :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "school"
    t.string   "term"
    t.date     "year"
    t.string   "invitation_code_student"
    t.string   "invitation_code_teacher"
    t.string   "created_by"
    t.boolean  "active",                  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invite_students", :force => true do |t|
    t.text     "email"
    t.integer  "course_id"
    t.integer  "invited_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invite_students", ["course_id"], :name => "index_invite_students_on_course_id"

  create_table "invite_teachers", :force => true do |t|
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "course_id"
    t.integer  "invited_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invite_teachers", ["course_id"], :name => "index_invite_teachers_on_course_id"
  add_index "invite_teachers", ["email"], :name => "index_invite_teachers_on_email"

  create_table "like_answers", :force => true do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "like_answers", ["answer_id"], :name => "index_like_answers_on_answer_id"
  add_index "like_answers", ["user_id"], :name => "index_like_answers_on_user_id"

  create_table "likes", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["post_id"], :name => "index_likes_on_post_id"
  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "links", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "course_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "attached"
  end

  add_index "posts", ["course_id"], :name => "index_posts_on_course_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "questions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["course_id"], :name => "index_roles_on_course_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
