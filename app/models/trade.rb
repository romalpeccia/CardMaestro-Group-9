class Trade < ApplicationRecord
    belongs_to :sender, :class_name => "User"
    belongs_to :reciever, :class_name=> "User"

    has_many :sender_cards, :class_name => "CardOffer", :foreign_key => 'sender_cards_id'
    has_many :reciever_cards, :class_name => 'CardOffer', :foreign_key => 'reciever_cards_id'
end
