class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :value
      t.string :comment
      t.timestamps
    end
    add_reference :ratings, :trades, null: false, foreign_key: true
  end
end
