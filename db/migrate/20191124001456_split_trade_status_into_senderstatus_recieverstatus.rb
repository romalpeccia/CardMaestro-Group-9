class SplitTradeStatusIntoSenderstatusRecieverstatus < ActiveRecord::Migration[6.0]
  def change
    rename_column :trades, :status, :reciever_status 
    add_column :trades, :sender_status, :string
  end
end
