class SearchpageController < ApplicationController
  
  def index
    
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
