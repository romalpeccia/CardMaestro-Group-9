class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #associations
  has_many :card_owned, dependent: :destroy
  has_many :card_needed, dependent: :destroy
  has_many :sent_trades, :class_name => 'Trade', :foreign_key => 'sender_id'
  has_many :recieved_trades, :class_name => 'Trade', :foreign_key => 'reciever_id'
  has_many :sent_pending_trades, :class_name => 'PendingTrade', :foreign_key => 'sender_id'
  has_many :recieved_pending_trades, :class_name => 'PendingTrade', :foreign_key => 'reciever_id'
end
