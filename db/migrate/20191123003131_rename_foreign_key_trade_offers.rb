class RenameForeignKeyTradeOffers < ActiveRecord::Migration[6.0]
  def change
    rename_column :card_offers, :receiver_cards_id, :reciever_cards_id
    remove_foreign_key :card_offers, :trades, column: :receiver_cards_id

    add_foreign_key :card_offers, :trades, column: :reciever_cards_id, primary_key: :id 

  end
end
