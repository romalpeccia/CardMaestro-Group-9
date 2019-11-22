class SearchpageController < ApplicationController
  
  def index
   
  end 

  def states
    render json: CS.states(params[:country]).to_json
  end

  def cities
    render json: CS.cities(params[:state], params[:country]).to_json
  end


  def search

    @cards = Card.all
    @sets = CardSet.all
  
    
    @search_term = params[:search]
    current_user_param = current_user.id
    
    #obtain the search term
    @results = CardOwned.all.where("lower(card_name) LIKE lower(:search) and user_id <> :current_user_id", search: "%#{@search_term}%", current_user_id: current_user_param )

  end
end
