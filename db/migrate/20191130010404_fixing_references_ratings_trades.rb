class FixingReferencesRatingsTrades < ActiveRecord::Migration[6.0]
  def change
    remove_reference :trades, :ratings, null: false, foreign_key: true
    add_reference :ratings, :trades, foreign_key: true
  end
end
