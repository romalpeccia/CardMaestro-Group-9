class AddForeignkeysRemoveUsersFromTrades < ActiveRecord::Migration[6.0]
  def change
      remove_reference :trades, :users, null: false, foreign_key: true

      remove_column :trades, :initiator
      remove_column :trades, :reciever
      rename_column :trades, :initiator_cards, :sender_cards
      change_table :trades do |t|
          t.references :sender
          t.references :reciever
      end
      add_foreign_key :trades, :users, column: :sender_id, primary_key: :id 
      add_foreign_key :trades, :users, column: :reciever_id, primary_key: :id 

  end
end
