# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_29_225142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_neededs", force: :cascade do |t|
    t.string "card_name"
    t.float "value"
    t.string "quality"
    t.boolean "foil"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "card_id", null: false
    t.index ["card_id"], name: "index_card_neededs_on_card_id"
    t.index ["user_id"], name: "index_card_neededs_on_user_id"
  end

  create_table "card_offers", force: :cascade do |t|
    t.string "card_name"
    t.float "value"
    t.string "quality"
    t.boolean "foil"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sender_cards_id"
    t.bigint "reciever_cards_id"
    t.bigint "card_id", null: false
    t.index ["card_id"], name: "index_card_offers_on_card_id"
    t.index ["reciever_cards_id"], name: "index_card_offers_on_reciever_cards_id"
    t.index ["sender_cards_id"], name: "index_card_offers_on_sender_cards_id"
  end

  create_table "card_owneds", force: :cascade do |t|
    t.string "card_name"
    t.float "value"
    t.string "quality"
    t.boolean "foil"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "card_id", null: false
    t.index ["card_id"], name: "index_card_owneds_on_card_id"
    t.index ["user_id"], name: "index_card_owneds_on_user_id"
  end

  create_table "card_sets", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "release_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "set"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "card_set_id", null: false
    t.index ["card_set_id"], name: "index_cards_on_card_set_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "city"
    t.string "province"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "value"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "trades_id", null: false
    t.index ["trades_id"], name: "index_ratings_on_trades_id"
  end

  create_table "trades", force: :cascade do |t|
    t.string "sender_cards"
    t.string "reciever_cards"
    t.string "reciever_status"
    t.float "sender_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sender_id"
    t.bigint "reciever_id"
    t.float "reciever_value"
    t.string "sender_status"
    t.index ["reciever_id"], name: "index_trades_on_reciever_id"
    t.index ["sender_id"], name: "index_trades_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "city"
    t.string "province"
    t.string "country"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "card_neededs", "cards"
  add_foreign_key "card_neededs", "users"
  add_foreign_key "card_offers", "cards"
  add_foreign_key "card_offers", "trades", column: "reciever_cards_id"
  add_foreign_key "card_offers", "trades", column: "sender_cards_id"
  add_foreign_key "card_owneds", "cards"
  add_foreign_key "card_owneds", "users"
  add_foreign_key "cards", "card_sets"
  add_foreign_key "ratings", "trades", column: "trades_id"
  add_foreign_key "trades", "users", column: "reciever_id"
  add_foreign_key "trades", "users", column: "sender_id"
end
