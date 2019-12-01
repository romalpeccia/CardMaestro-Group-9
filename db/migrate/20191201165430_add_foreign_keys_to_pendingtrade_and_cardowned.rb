class AddForeignKeysToPendingtradeAndCardowned < ActiveRecord::Migration[6.0]
  #added foreignkey to cardowned in next migration
  def change
    remove_column :pending_trades, :sender_id
    remove_column :pending_trades, :reciever_id
    change_table :pending_trades do |t|
      t.references :sender
      t.references :reciever
  end
  add_foreign_key :pending_trades, :users, column: :sender_id, primary_key: :id 
  add_foreign_key :pending_trades, :users, column: :reciever_id, primary_key: :id 
  


  end
end
