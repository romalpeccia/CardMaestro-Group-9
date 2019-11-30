class RatingsController < ApplicationController
  def index
  end
  def create
      flash[:notice] = params
      rated_trade = Trade.find_by(id: params[:trade_id])
      flash[:notice] = rated_trade
      new_rating = rated_trade.ratings.new
      new_rating.value = params[:star_value] 
      new_rating.user_id = params[:ratee_id]
      new_rating.rater = params[:rater_id]
      new_rating.comment =  params[:rating_comment]
     
      rated_trade.ratings << new_rating

      redirect_to trade_path(current_user.id)
  end
end

