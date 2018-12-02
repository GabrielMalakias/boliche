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

ActiveRecord::Schema.define(version: 2018_12_01_122547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "frames", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "game_id"
    t.integer "score"
    t.integer "number"
    t.integer "status", default: 0
    t.index ["game_id"], name: "index_frames_on_game_id"
    t.index ["player_id"], name: "index_frames_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "current_player_id"
    t.bigint "player_id"
    t.integer "frame_number", default: 0
    t.integer "status", default: 0
    t.index ["current_player_id"], name: "index_games_on_current_player_id"
    t.index ["player_id"], name: "index_games_on_player_id"
  end

  create_table "games_players", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "game_id"
    t.index ["game_id"], name: "index_games_players_on_game_id"
    t.index ["player_id"], name: "index_games_players_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "player_id"
    t.integer "points"
    t.index ["game_id"], name: "index_scores_on_game_id"
    t.index ["player_id"], name: "index_scores_on_player_id"
  end

  create_table "shots", force: :cascade do |t|
    t.bigint "frame_id"
    t.integer "knocked_down_pins"
    t.index ["frame_id"], name: "index_shots_on_frame_id"
  end

end
