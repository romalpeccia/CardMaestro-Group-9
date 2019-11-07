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

            #Find the user
            user = User.find_by(email: params[:card][:user])
            
            card_name = params[:card][:card_name]
            value = params[:card][:value]
            quality = params[:card][:quality]
            foil = params[:card][:foil]
            
            #attach a card owned object to the user
            user.card_owned.create(card_name: card_name,value: value, quality: quality, foil: foil )

            
            if user.save
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


