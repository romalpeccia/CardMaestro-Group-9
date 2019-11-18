class HomeController < ApplicationController
    def index
    
    user_id = current_user.id
    @collection_error = false

    target_user = User.find_by(id: user_id)
    if target_user
      @target_email = target_user.email
      @collection_card_owned = target_user.card_owned
      @collection_card_needed = target_user.card_needed
      
    else
      flash.now[:alert] = "User Not Found"
      @collection_error = true
    end
    end
end
