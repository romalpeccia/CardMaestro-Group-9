class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :fname
      t.string :lname
      t.string :city
      t.sting :email
      t.string :enc_pwd
      t.string :salt
      t.boolean :public

      t.timestamps
    end
  end
end
