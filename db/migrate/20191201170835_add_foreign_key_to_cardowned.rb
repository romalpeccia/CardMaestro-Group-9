class AddForeignKeyToCardowned < ActiveRecord::Migration[6.0]
  def change
    change_table :card_owneds do |t|
      t.references :sender_cards
      t.references :receiver_cards
  end
  add_foreign_key :card_owneds, :pending_trades, column: :sender_cards_id, primary_key: :id 
  add_foreign_key :card_owneds, :pending_trades, column: :receiver_cards_id, primary_key: :id 
  end
end
