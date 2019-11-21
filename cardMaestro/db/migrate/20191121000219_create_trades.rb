class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.integer :initiator_id
      t.integer :reciever_id
      t.string :initiator_cards
      t.string :reciever_cards
      t.string :status
      t.float :value

      t.timestamps
    end
  end
end
