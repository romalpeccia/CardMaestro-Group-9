class CreateCardSets < ActiveRecord::Migration[6.0]
  def change
    create_table :card_sets do |t|
      t.string :name
      t.string :code
      t.datetime :release_date

      t.timestamps
    end
  end
end
