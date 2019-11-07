class Card < ApplicationRecord
    #validate no duplicate names?

    belongs_to :card_set
end
