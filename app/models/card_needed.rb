class CardNeeded < ApplicationRecord
    belongs_to :user
    belongs_to :card

    validates :value, :numericality => { :greater_than_or_equal_to => 0 }
end
