class CreateCardOwneds < ActiveRecord::Migration[6.0]
  def change
    create_table :card_owneds do |t|
      t.string :user
      t.string :card_name
      t.float :value
      t.string :quality
      t.boolean :foil

      t.timestamps
    end
  end
end
