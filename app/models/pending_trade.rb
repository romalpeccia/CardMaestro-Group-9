class PendingTrade < ApplicationRecord
    belongs_to :sender, :class_name => "User"
    belongs_to :reciever, :class_name=> "User"

    has_many :sender_cards, :class_name => "CardOwned", :foreign_key => 'sender_cards_id'
    has_many :reciever_cards, :class_name => 'CardOwned', :foreign_key => 'reciever_cards_id'
    has_many :sender_wishlist_cards, :class_name => "CardNeeded", :foreign_key => 'sender_wishlist_cards_id'
    has_many :reciever_wishlist_cards, :class_name => 'CardNeeded', :foreign_key => 'reciever_wishlist_cards_id'

    validates :sender_value, :numericality => { :greater_than_or_equal_to => 0 }
    validates :reciever_value, :numericality => { :greater_than_or_equal_to => 0 }
end
