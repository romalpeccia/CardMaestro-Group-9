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

    flash[:notice] = params

    #obtain the search term
    @search_term = params[:search]
    current_user_param = current_user.id
  
    if !params[:mode]

      #basic search
      @results = CardOwned.all.where(
        "lower(card_name) LIKE lower(:search) and user_id <> :current_user_id",
         search: "%#{@search_term}%", current_user_id: current_user_param )
   
    elsif params[:mode] == "Advanced" 

      condition = params[:condition]
      set = params[:set]
      foil = params[:foil]

      minprice = params[:minprice]
      maxprice = params[:maxprice]

      country = params[:country]
      state = params[:state]
      city = params[:city]
      
      #advanced search
      @results = CardOwned.joins(:card).all.where(
        "lower(card_name) LIKE lower(:search) and user_id <> :current_user_id and foil = :foil and lower(quality) like lower(:quality)",
       search: "%#{@search_term}%", foil: foil, quality: "%#{condition}%",  current_user_id: current_user_param )
  

    end
  end
end
