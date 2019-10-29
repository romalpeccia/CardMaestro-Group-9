class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :city
      t.string :email
      t.string :enc_pwd
      t.string :salt
      t.boolean :public

      t.timestamps
    end
  end
end
