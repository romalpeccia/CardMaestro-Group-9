#TODO refactor 'add to collection' and 'add to wishlist '
#fix repeated instance variables
class CardsController < ApplicationController 

    def index
        @sets = CardSet.all

        render 'new'
        
    end

    def show
        #this method returns all the cards associated with a set
        
        set = params[:id]
        card_list = Card.where(set: set)

        render json: card_list

    end

    def new 
        @sets = CardSet.all
    end
    def create
        if params[:commit] == 'Add to Collection'

            #Find the user
            user = User.find_by(email: params[:card][:user])
            card_name = params[:card][:card_name]
            value = params[:card][:value]
            quality = params[:card][:quality]
            foil = params[:card][:foil]
            set = params[:card][:set]
        
            #attach a card owned object to the user
            new_card = Card.find_by(name: card_name, set: set)
            if (new_card)
                new_card_owned = new_card.card_owned.new(card_name: card_name,value: value, quality: quality, foil: foil )
                #user.card_owned << new_card_owned
                if user.card_owned << new_card_owned 
                    flash[:notice] = params[:card][:card_name] + ' added to collection'
                else
                    flash[:alert] = "error adding card to collection"
                end
            else
                flash[:alert] = "card not in master card db"
            end
        elsif params[:commit] == 'Add to Wishlist'
            #Find the user
            user = User.find_by(email: params[:card][:user])
            
            card_name = params[:card][:card_name]
            value = params[:card][:value]
            quality = params[:card][:quality]
            foil = params[:card][:foil]
            set = params[:card][:set]
            #attach a card owned object to the user

            new_card = Card.find_by(name: card_name, set: set)
            if (new_card)
                new_card_wishlist = new_card.card_needed.new(card_name: card_name,value: value, quality: quality, foil: foil )
                 
                if user.card_needed << new_card_wishlist
                    flash[:notice] = params[:card][:card_name] + ' added to wishlist'
                else
                    flash[:alert] = "error adding card to wishlist"
                end
            else
                flash[:alert] = "card not in master card db"
            end
        end

        redirect_to new_card_path
    end
private
    def card_params
        params.require(:card).permit(:card_name, :value, :user, :foil, :quality)
    end

end


