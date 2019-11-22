class RenameRecieveridAndInitiatoridOfTrades < ActiveRecord::Migration[6.0]
  def change
    rename_column :trades, :reciever_id, :reciever
    rename_column :trades, :initiator_id, :initiator
  end
end
