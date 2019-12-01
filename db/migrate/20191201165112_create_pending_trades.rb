class CreatePendingTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :pending_trades do |t|
      t.string "sender_cards"
      t.string "reciever_cards"
      t.string "reciever_status"
      t.float "sender_value"
      t.bigint "sender_id"
      t.bigint "reciever_id"
      t.float "reciever_value"
      t.string "sender_status"
      t.timestamps

      
    end
  end
end
