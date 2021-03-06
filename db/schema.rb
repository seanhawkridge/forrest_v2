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

ActiveRecord::Schema.define(version: 20161021194344) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "match_id"
    t.integer  "challenger_id"
    t.integer  "challenged_id"
    t.string   "status"
    t.string   "result"
    t.index ["match_id"], name: "index_challenges_on_match_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "round_id"
    t.integer  "player_one_id"
    t.integer  "player_two_id"
    t.integer  "winner_id"
    t.boolean  "bye",           default: false
    t.index ["round_id"], name: "index_games_on_round_id", using: :btree
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "round_id"
    t.integer  "player_one_id"
    t.integer  "player_two_id"
    t.integer  "player_one_score"
    t.integer  "player_two_score"
    t.integer  "winner_id"
    t.boolean  "bye",                  default: false
    t.boolean  "successful_challenge", default: false
    t.string   "match_type"
    t.integer  "challenge_id"
    t.index ["challenge_id"], name: "index_matches_on_challenge_id", using: :btree
    t.index ["round_id"], name: "index_matches_on_round_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.integer  "games",          default: 0
    t.integer  "wins",           default: 0
    t.integer  "win_percentage", default: 0
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "points"
    t.integer  "position"
    t.string   "slack_handle"
    t.index ["user_id"], name: "index_players_on_user_id", using: :btree
  end

  create_table "players_tournaments", id: false, force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "player_id",     null: false
    t.index ["player_id", "tournament_id"], name: "index_players_tournaments_on_player_id_and_tournament_id", using: :btree
    t.index ["tournament_id", "player_id"], name: "index_players_tournaments_on_tournament_id_and_player_id", using: :btree
  end

  create_table "rounds", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "tournament_id"
    t.integer  "number"
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id", using: :btree
  end

  create_table "tournaments", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.integer  "champion_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "image"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_foreign_key "challenges", "matches"
  add_foreign_key "games", "rounds"
  add_foreign_key "matches", "rounds"
  add_foreign_key "rounds", "tournaments"
end
