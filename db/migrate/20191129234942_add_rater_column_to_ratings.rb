class AddRaterColumnToRatings < ActiveRecord::Migration[6.0]
  def change
    add_column :ratings, :rater_id, :integer
  end
end
