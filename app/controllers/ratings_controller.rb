class RatingsController < ApplicationController
  def index
  end
  def create
     
      rated_trade = Trade.find_by(id: params[:trade_id])
      
      new_rating = rated_trade.ratings.new
      new_rating.value = params[:star_value] 
      new_rating.user_id = params[:ratee_id]
      new_rating.rater = params[:rater_id]
      new_rating.comment =  params[:rating_comment]
     
      rated_trade.ratings << new_rating
      other_user = User.find_by(id: params[:ratee_id])
      flash[:notice] = "You rated #{other_user.email} #{params[:star_value]} stars! Message: #{params[:rating_comment]}"
      redirect_to trade_path(current_user.id)
  end
end

