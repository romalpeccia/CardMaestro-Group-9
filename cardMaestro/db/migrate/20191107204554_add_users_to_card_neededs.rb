class AddUsersToCardNeededs < ActiveRecord::Migration[6.0]
  def change
    add_reference :card_neededs, :users, null: false, foreign_key: true
  end
end
