class Card < ApplicationRecord

    belongs_to :card_set
    has_many :card_owned
    has_many :card_needed
end
