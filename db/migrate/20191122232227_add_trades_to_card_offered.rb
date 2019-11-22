class AddTradesToCardOffered < ActiveRecord::Migration[6.0]
  def change
    change_table :card_offers do |t|
      t.references :sender_cards
      t.references :receiver_cards
  end
  add_foreign_key :card_offers, :trades, column: :sender_cards_id, primary_key: :id 
  add_foreign_key :card_offers, :trades, column: :receiver_cards_id, primary_key: :id 

  end
end
