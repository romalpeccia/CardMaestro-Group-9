class CardOffer < ApplicationRecord
    has_and_belongs_to_many :sender_cards, :class_name => "Trade"
    has_and_belongs_to_many :reciever_cards, :class_name=> "Trade"
    belongs_to :card
end
