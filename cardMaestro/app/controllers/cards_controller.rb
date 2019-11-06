class CardsController < ApplicationController
    def new
        #@cards = Card.all
        #temp = CardSet.new
        @sets = CardSet.all
    end
    def create_card_owned
    end
    def create_card_needed
    end

end
