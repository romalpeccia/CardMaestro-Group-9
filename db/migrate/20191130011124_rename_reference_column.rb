class RenameReferenceColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :ratings, :trades_id, :trade_id
  end
end
