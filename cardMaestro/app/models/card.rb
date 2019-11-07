class Card < ApplicationRecord
    #validate no duplicate names?

    belongs_to :card_set
    has_many :card_owned
    has_many :card_needed
end
