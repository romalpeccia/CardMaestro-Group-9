class TradesController < ApplicationController
  def index
    render 'show'
  end
  def new
      target_id = params[:id].to_i
      
      user_id = current_user.id
      @is_self = false
      @collection_error = false

      @target_user = User.find_by(id: target_id)
      
      if @target_user
        @target_email = @target_user.email
        @collection_card_owned = @target_user.card_owned
        @collection_card_needed = @target_user.card_needed
        if target_id == current_user.id
          @is_self = true;
        else
          user = User.find_by(id: user_id)
          card_owned_ids = user.card_owned.map { |row| row.card_id }
          card_needed_ids = user.card_needed.map { |row| row.card_id }
          @collection_card_owned = card_needed_ids.collect { |id| @collection_card_owned.find_by(card_id: id)}.compact
          @collection_card_needed = card_owned_ids.collect { |id| @collection_card_needed.find_by(card_id: id)}.compact
        end
      else
        flash.now[:alert] = "user not found"
        @collection_error = true
      end

      
      render 'new'
  end
  def create
      #temporary flash for debugging
      @target_user = User.find_by(id: params[:reciever_id])
      if (params[:sender_value] != 0 and params[:reciever_value]  != 0) and (params[:sender_value] != "" and params[:reciever_value]  != "")
        flash[:alert] = "You cannot send and recieve money in the same trade"
        flash[:notice] = params
        redirect_to new_trade_path(id: @target_user.id)
      
      else
        s_v = params[:sender_value].to_i
        r_v = params[:reciever_value].to_i
        if s_v == "" or s_v == nil
          s_v = 0
        end
        if r_v == "" or r_v == nil
          r_v = 0
        end
        if s_v < 0 or r_v < 0 #ideally user shouldn't ever get to this point unless they are trying to cheat the post request
          flash[:alert] = "error: cannot trade negative money"
          redirect_to new_trade_path(id: @target_user.id)
        else
          flash[:notice] = params

          sender = User.find_by(id: params[:sender_id]) 
          reciever = User.find_by(id: params[:reciever_id])
          sender_value = 0 #note we arent using these atm
          reciever_value = 0

          trade = Trade.new(sender_status: "Accepted", reciever_status: "Pending")
          no_card_flag = 1
          params.each do |key, value|
              if key.include? "card_owned" 
                no_card_flag = 0
                card = CardOwned.find_by(id: value)
                if card.value != nil
                  sender_value = sender_value + card.value
                end
                
                #save card to list of reciever_cards (cards the reciever will send)
                card_offer = CardOffer.new
                card_offer.card_name = card.card_name
                card_offer.quality = card.quality
                card_offer.value = card.value
                card_offer.foil = card.foil
                card_offer.card = card.card

                card.card.card_offer << card_offer
              
                trade.reciever_cards << card_offer

              elsif key.include? "card_needed"
                no_card_flag = 0
                card = CardNeeded.find_by(id: value)
                if card.value != nil
                  reciever_value = reciever_value + card.value
                end

                #save card to list of sender_cards (cards the sender will send)
                card_offer = CardOffer.new
                card_offer.card_name = card.card_name
                card_offer.quality = card.quality
                card_offer.value = card.value
                card_offer.foil = card.foil
                card_offer.card = card.card

                card.card.card_offer << card_offer
              
                trade.sender_cards << card_offer

              end
          end
          if no_card_flag == 1
            flash[:alert] = "Select at least one card"
            redirect_to new_trade_path(id: @target_user.id)
          else
            trade.sender_value = s_v
            trade.reciever_value = r_v
            trade.sender = sender
            trade.reciever = reciever
    
            sender.sent_trades << trade 
            reciever.recieved_trades << trade
    
    
              #saving the associations and trade object
            trade.save
            flash[:notice] = trade
            flash[:alert] = trade.errors
            redirect_to trade_path(current_user.id)
          end #end if no cards were selected
        end #end if sender and reciever values were nonnegative
      end #end if sender AND reciever values are both inputted
      
  end

  def show
      
      #sender_status is by default "Accepted" 
        #trades the current user sent, waiting for reciever to change status to accepted
      @pending_sent_trades = Trade.where(sender_id: current_user.id, reciever_status: "Pending" )
        #trades the current user recieved, waiting for current user to change status to accepted
      @pending_recieved_trades = Trade.where(reciever_id: current_user.id, reciever_status: "Pending")

        

      #@accepted_sent_trades = Trade.where(sender_id: current_user.id , reciever_status: "Accepted").or(Trade.where(sender_id: current_user.id , sender_status: "Accepted"))
      #@accepted_recieved_trades = Trade.where(reciever_id: current_user.id , reciever_status: "Accepted").or(Trade.where(reciever_id: current_user.id , sender_status: "Accepted"))

      all_curr_user_trades = Trade.where(sender_id: current_user.id).or(Trade.where(reciever_id: current_user.id))
      #get all trades where neither person has completed
      #get all trades where user is the one not completed
      #get all trades where the user is waiting for the other person to complete
      @accepted_trades = all_curr_user_trades.where(reciever_status: "Accepted", sender_status: "Accepted").or(all_curr_user_trades.where(reciever_status: "Completed", sender_status: "Accepted")).or(all_curr_user_trades.where(reciever_status: "Accepted", sender_status: "Completed"))




      @completed_sent_trades = Trade.where(sender_id: current_user.id, reciever_status: "Completed", sender_status: "Completed")
      @completed_recieved_trades = Trade.where(reciever_id: current_user.id, reciever_status: "Completed", sender_status: "Completed")

  end

  def update

    trade = Trade.find_by(id: params[:id])
    #figure out whether the current user is the sender or the reciever of the trade
    if (current_user.id == trade.reciever.id)
      curr_user_type = "R"
      other_user = User.find_by(id: trade.sender.id)
    elsif (current_user.id == trade.sender.id)
      curr_user_type = "S"
      other_user = User.find_by(id: trade.reciever.id)
    else #should never reach here unless user tries to break the put request
        flash[:alert] = "user somehow tried to update a trade that wasn't theirs"
        redirect_to trade_path(current_user.id)
    end

    #deal with the types of possible updates 
    if params[:commit] == "pending_accepted"
        update_helper(trade, curr_user_type, "Accepted")
        flash[:notice] = "Trade with #{other_user.email} accepted!"
    elsif params[:commit] == "pending_declined"
        update_helper(trade, "R", "Declined")
        update_helper(trade, "S", "Declined")
        flash[:alert] = "Trade with #{other_user.email} declined!"
    else
      flash[:alert] = "error updating trade"
    end
    
    redirect_to trade_path(current_user.id)
  end

  
end

def update_helper(t, c, s) #trade, current_user_type, status - wasnt sure how scoping works in ruby, playing it safe
  if c == "R"
    t.update(reciever_status: s)
  end
  if c == "S"
    t.update(sender_status: s)
  end
end