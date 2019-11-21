class AddLocationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :country, :string
  end
end
