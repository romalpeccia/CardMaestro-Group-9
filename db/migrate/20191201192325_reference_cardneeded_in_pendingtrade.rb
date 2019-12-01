class ReferenceCardneededInPendingtrade < ActiveRecord::Migration[6.0]
  def change
    change_table :card_neededs do |t|
      t.references :sender_wishlist_cards
      t.references :reciever_wishlist_cards
    end
  add_foreign_key :card_neededs, :pending_trades, column: :sender_wishlist_cards_id, primary_key: :id 
  add_foreign_key :card_neededs, :pending_trades, column: :reciever_wishlist_cards_id, primary_key: :id 

  end
end
