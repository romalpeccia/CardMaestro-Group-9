class Ratingsremovereference < ActiveRecord::Migration[6.0]
  def change
    remove_reference :ratings, :trades, null: false, foreign_key: true
  end
end
