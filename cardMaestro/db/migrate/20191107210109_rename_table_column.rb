class RenameTableColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :card_owneds, :users_id, :user_id
    rename_column :card_neededs, :users_id, :user_id  
  end
end
