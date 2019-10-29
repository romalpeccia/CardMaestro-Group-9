class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :card_name
      t.string :set_name
      t.string :set_number
      t.float :market_value

      t.timestamps
    end
  end
end
