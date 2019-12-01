class RenameRecieverInPendingtrade < ActiveRecord::Migration[6.0]
  def change
    remove_column :card_owneds, :receiver_cards_id
    change_table :card_owneds do |t|
      t.references :reciever_cards
  end
  add_foreign_key :card_owneds, :pending_trades, column: :reciever_cards_id, primary_key: :id 
  end
end
