class SearchpageController < ApplicationController
  def index
  end

  def search
    #obtain the search term
    search_term = params[:param1]
    current_user_param = params[:param2]
    @results = CardOwned.all.where("lower(card_name) LIKE lower(:search) and user_id <> :current_user_id", search: "%#{search_term}%", current_user_id: current_user_param )

  end
end
