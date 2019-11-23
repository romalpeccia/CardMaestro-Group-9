class Addcardreferencetooffered < ActiveRecord::Migration[6.0]
  def change
    add_reference :card_offers, :card  , null: false, foreign_key: true
  end
end
