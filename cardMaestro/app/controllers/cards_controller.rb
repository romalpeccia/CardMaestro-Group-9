#TODO remove User from card owned table, add set to card owned table
#fix repeated instance variables
#remo
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
            set = params[:card][:set]
            #attach a card owned object to the user
            new_card = Card.find_by(name: card_name)
            if (new_card)
                new_card.card_owned.build(card_name: card_name,value: value, quality: quality, foil: foil )
                user.card_owned.create(card_name: card_name,value: value, quality: quality, foil: foil )
                if user.save
                    flash[:notice] = params[:card][:card_name] + ' added to collection'
                else
                    flash[:notice] = "error adding card to collection"
                end
            else
                flash[:notice] = "card not in master card db"
            end
        elsif params[:commit] = 'Add to Wishlist'
            #Find the user
            user = User.find_by(email: params[:card][:user])
            
            card_name = params[:card][:card_name]
            value = params[:card][:value]
            quality = params[:card][:quality]
            foil = params[:card][:foil]
            set = params[:card][:set]
            #attach a card owned object to the user

            new_card = Card.find_by(name: card_name)
            if (new_card)
                new_card.card_needed.build(card_name: card_name,value: value, quality: quality, foil: foil )
                user.card_needed.create(card_name: card_name,value: value, quality: quality, foil: foil )
                if user.save
                    flash[:notice] = params[:card][:card_name] + ' added to collection'
                else
                    flash[:notice] = "error adding card to collection"
                end
            else
                flash[:notice] = "card not in master card db"
            end
        end
        render 'new'
    end
private
    def card_params
        params.require(:card).permit(:card_name, :value, :user, :foil, :quality)
    end

end


