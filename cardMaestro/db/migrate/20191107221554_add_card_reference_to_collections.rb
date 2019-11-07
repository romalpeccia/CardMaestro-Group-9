class AddCardReferenceToCollections < ActiveRecord::Migration[6.0]
  def change
      add_reference :card_owneds, :card  , null: false, foreign_key: true
      add_reference :card_neededs, :card , null: false, foreign_key: true
  end
end
