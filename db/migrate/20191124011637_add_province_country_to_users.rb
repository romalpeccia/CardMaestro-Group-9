class AddProvinceCountryToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :province2, :string
    add_column :users, :country2, :string
  end
end
