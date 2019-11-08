class WelcomeController < ApplicationController
  def index
  
    #if search query, redirect to search controller
    if params[:search]
      search_term = params[:search]
      redirect_to searchpage_search_path(:param1 =>search_term) 
    end
  end


end
