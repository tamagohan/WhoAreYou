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

ActiveRecord::Schema.define(:version => 20120104010738) do

  create_table "accounts", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
  end

  create_table "avatar_tweets", :force => true do |t|
    t.integer  "avatar_twitter_id"
    t.decimal  "tw_av_id"
    t.string   "tw_av_str"
    t.integer  "tw_av_type"
    t.string   "tw_av_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatar_twitters", :force => true do |t|
    t.integer  "avatar_id"
    t.string   "auth_id"
    t.string   "auth_password"
    t.string   "twitter_name"
    t.decimal  "last_cp_tw_id", :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", :force => true do |t|
    t.integer  "account_id"
    t.integer  "avatar_tweet_id"
    t.string   "name"
    t.datetime "birthday"
    t.integer  "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_url"
  end

  create_table "avatars_items", :id => false, :force => true do |t|
    t.integer "avatar_id"
    t.integer "item_id"
  end

  create_table "emotional_words", :force => true do |t|
    t.string   "word"
    t.string   "reading"
    t.integer  "pos"
    t.decimal  "semantic_orientation", :precision => 10, :scale => 8, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emotional_words", ["word"], :name => "index_emotional_words_on_word"

  create_table "growth_logs", :force => true do |t|
    t.integer  "avatar_id"
    t.integer  "growth_type"
    t.boolean  "is_informed", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "item_type"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.integer  "twitter_id"
    t.decimal  "tw_id"
    t.string   "tw_str"
    t.integer  "tw_type"
    t.string   "tw_image_url"
    t.datetime "tw_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "twitters", :force => true do |t|
    t.integer  "account_id"
    t.integer  "tweet_id"
    t.string   "oauth_token"
    t.string   "oauth_verifier"
    t.decimal  "last_tw_id",     :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
