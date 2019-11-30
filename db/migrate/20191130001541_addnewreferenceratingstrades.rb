class Addnewreferenceratingstrades < ActiveRecord::Migration[6.0]
  def change
    add_reference :trades, :ratings, foreign_key: true
  end
end
