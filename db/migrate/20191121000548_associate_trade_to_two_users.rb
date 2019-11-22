class AssociateTradeToTwoUsers < ActiveRecord::Migration[6.0]
  def change
      add_reference :trades, :users, null: false, foreign_key: true
  end
end
