class WelcomeController < ApplicationController
  def index
  
    #if search query, redirect to search controller
    if params[:search]
      search_term = params[:search]
      current_user_param = current_user.id
      redirect_to searchpage_search_path(:param1 =>search_term, :param2 =>current_user_param) 
    end
  end


end
