class HomeController < ApplicationController
    def index
    
    #IS this block necessary?
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
    #
    @highest_wishlist_cards = CardNeeded.group(:card).order('count_all DESC').limit(10).count
    @highest_collection_cards =  CardOwned.group(:card).order('count_all DESC').limit(10).count
    
   




    all_users = User.all
    card_owned_ids = current_user.card_owned
    card_needed_ids = current_user.card_needed
    target1 = nil
    count1 = 0
    target2 = nil
    count2 = 0
    target3 = nil
    count3 = 0
    cards_needed1 = nil
    cards_needed2 = nil
    cards_needed3 = nil
    cards_owned1 = nil
    cards_owned2 = nil
    cards_owned3  = nil
    all_users.each do |target_user|
      if target_user.id != current_user.id
        target_collection_card_owned = target_user.card_owned
        target_collection_card_needed = target_user.card_needed

        collection_card_owned = card_needed_ids.map { |card| target_collection_card_owned.find_by(card_id: card.card_id, quality: card.quality, foil: card.foil)}.compact
        collection_card_needed = card_owned_ids.map { |card| target_collection_card_needed.find_by(card_id: card.card_id, quality: card.quality, foil: card.foil)}.compact
        target_count = collection_card_owned.count + collection_card_needed.count
        if target_count > count1
            count3 = count2
            target3 = target2
            cards_needed3 = cards_needed2
            cards_owned3 = cards_owned2
            count2 = count1
            target2 = target1
            cards_needed2 = cards_needed1
            cards_owned2 = cards_owned1

            cards_needed1 = collection_card_needed
            cards_owned1 = collection_card_owned
            count1 = target_count
            target1 = target_user
        elsif target_count > count2
            target3 = target2
            count3 = count2
            cards_needed3 = cards_needed2
            cards_owned3 = cards_owned2

            cards_needed2 = collection_card_needed
            cards_owned2 = collection_card_owned
            count2 = target_count
            target2 = target_user
        elsif target_count > count3
            cards_needed3 = collection_card_needed
            cards_owned3 = collection_card_owned
            count3 = target_count
            target3 = target_user

        end
      end
    end


    @target_array = []
    @target_array[0] = []
    @target_array[1] = []
    @target_array[2] = []
    if(target1 and cards_needed1 and cards_owned1)
      @target_array[0] << target1
      #@target_array[0] << count1
      @target_array[0] << cards_needed1
      @target_array[0] << cards_owned1
    end

    if(target2 and cards_needed2 and cards_owned2)
      @target_array[1] << target2
      #@target_array[1] << count2
      @target_array[1] << cards_needed2
      @target_array[1] << cards_owned2
    end

    if(target3 and cards_needed3 and cards_owned3)
      @target_array[2] << target3
      #@target_array[2] << count3
      @target_array[2] << cards_needed3
      @target_array[2] << cards_owned3
    end

    #flash[:notice] = @target_array



    end
end
