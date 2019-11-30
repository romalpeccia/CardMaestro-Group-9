class RenameRatingRaterIdToRaterId < ActiveRecord::Migration[6.0]
  def change
    rename_column :ratings, :rater_id, :rater
  end
end
