class CardOffer < ApplicationRecord
    belongs_to :sender_cards, :class_name => "Trade"
    belongs_to :reciever_cards, :class_name=> "Trade"
end
