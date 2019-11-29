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

    #obtain the search term
    @search_term = params[:search]
    current_user_param = current_user.id
  
    if !params[:mode]

      #basic search
      @results = CardOwned.all.where(
        "lower(card_name) LIKE lower(:search) and user_id <> :current_user_id",
         search: "%#{@search_term}%", current_user_id: current_user_param )

      @results_wishlist = CardNeeded.all.where(
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

      if(foil == "")
        foilQuery = ""
      else
        foilQuery = " and foil = :foil"
      end
      
      #advanced search query
      @results = CardOwned.joins(:card).joins(:user).all.where(
        "lower(card_name) LIKE lower(:search)"+
        " and user_id <> :current_user_id"+
         foilQuery+
          " and lower(quality) like lower(:quality)"+
           " and lower(set) like lower(:set)"+
           " and lower(country) like lower(:country)"+
           " and lower(province) like lower(:state)"+
           " and lower(city) like lower(:city)"+
           " and value >= :minprice"+
           " and value <= :maxprice",
       search: "%#{@search_term}%",
       current_user_id: current_user_param, 
       quality: "%#{condition}%",
       foil: foil,
       set: "%#{set}%",

       minprice: minprice,
       maxprice: maxprice,
       country: "%#{country}%",
       state: "%#{state}%",
       city:"%#{city}%"
       )

       @results_wishlist = CardNeeded.joins(:card).joins(:user).all.where(
        "lower(card_name) LIKE lower(:search)"+
        " and user_id <> :current_user_id"+
          foilQuery +
          " and lower(quality) like lower(:quality)"+
           " and lower(set) like lower(:set)"+
           " and lower(country) like lower(:country)"+
           " and lower(province) like lower(:state)"+
           " and lower(city) like lower(:city)"+
           " and value >= :minprice"+
           " and value <= :maxprice",
       search: "%#{@search_term}%",
       current_user_id: current_user_param, 
       quality: "%#{condition}%",
       foil: foil,
       set: "%#{set}%",

       minprice: minprice,
       maxprice: maxprice,
       country: "%#{country}%",
       state: "%#{state}%",
       city:"%#{city}%"
       )

  

    end
  end
end
