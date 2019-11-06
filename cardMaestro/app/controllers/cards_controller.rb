#fix repeated instance variables
class CardsController < ApplicationController 
    def index
        @cards = Card.all
        @sets = CardSet.all
        render 'new'
    end
    def new
        @cards = Card.all 
        @sets = CardSet.all
    end
    def create
        @cards = Card.all
        @sets = CardSet.all
        if params[:commit] = 'Add to Collection'
            @newcard = CardOwned.new(card_params)
            if @newcard.save
                flash[:notice] = params#[:card][:card_name] + ' added to collection'
            else
                flash[:notice] = "error adding card to collection"
            end
        elsif params[:commit] = 'Add to Wishlist'
            @newcard = CardNeeded.new(card_params)
            if @newcard.save
                flash[:notice] = params[:card][:card_name] + ' added to wishlist'
            else
                flash[:notice] = "error adding card to collection"
            end 
        else
            flash[:notice] = 'form error'
            
        end
        render 'new'
    end
private
    def card_params
        params.require(:card).permit(:card_name, :value, :user, :foil, :quality)
    end

end


