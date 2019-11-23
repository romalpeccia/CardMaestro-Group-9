class CreateCardOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :card_offers do |t|
      t.string :card_name
      t.float :value
      t.string :quality
      t.boolean :foil

      t.timestamps
    end
  end
end
