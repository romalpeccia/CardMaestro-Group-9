class SplitTradeValueIntoSenderReciever < ActiveRecord::Migration[6.0]
  def change
    rename_column :trades, :value, :sender_value
    add_column :trades, :reciever_value, :float
  end
end
