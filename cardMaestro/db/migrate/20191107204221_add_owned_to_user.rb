class AddOwnedToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :card_owneds, :users, null: false, foreign_key: true
  end
end
