class CardOwned < ApplicationRecord
    belongs_to :user
    belongs_to :card
    has_and_belongs_to_many :sender_cards, :class_name => "PendingTrade"
    has_and_belongs_to_many :reciever_cards, :class_name=> "PendingTrade"

    validates :value, :numericality => { :greater_than_or_equal_to => 0 }
end
