class RatingsController < ApplicationController
  def index
  end
  def create
      flash[:notice] = params
      rated_trade = Trade.find_by(id: params[:trade_id])
      flash[:notice] = rated_trade
      new_rating = Rating.new
      new_rating.value = params[:star_value] 

     
      rated_trade.ratings << new_rating

      redirect_to trade_path(current_user.id)
  end
end

                 
#new_card = Card.find_by(name: card_name, set: set)
#f (new_card)
#    new_card_wishlist = new_card.card_needed.new(card_name: card_name,value: value, quality: quality, foil: foil )
    
 #   user.card_needed << new_card_wishlist