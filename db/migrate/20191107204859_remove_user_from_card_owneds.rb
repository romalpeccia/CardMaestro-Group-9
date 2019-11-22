class RemoveUserFromCardOwneds < ActiveRecord::Migration[6.0]
  def change
    remove_column :card_owneds, :user
    remove_column :card_neededs, :user
  end
end
