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
      flash[:notice] = params

      sender = User.find_by(id: params[:sender_id]) 
      reciever = User.find_by(id: params[:reciever_id])
      sender_value = 0
      reciever_value = 0

      trade = Trade.new(sender_status: "Accepted", reciever_status: "Pending")
      
      params.each do |key, value|
          if key.include? "card_owned" 
            card = CardOwned.find_by(id: value)
            if card.value != nil
              sender_value = sender_value + card.value
            end
            
            #save card to list of sender_cards
            card_offer = CardOffer.new
            card_offer.card_name = card.card_name
            card_offer.quality = card.quality
            card_offer.value = card.value
            card_offer.foil = card.foil
            card_offer.card = card.card

            card.card.card_offer << card_offer
          
            trade.sender_cards << card_offer

          elsif key.include? "card_needed"
            card = CardNeeded.find_by(id: value)
            if card.value != nil
              reciever_value = reciever_value + card.value
            end

            #save card to list of reciever_cards
            card_offer = CardOffer.new
            card_offer.card_name = card.card_name
            card_offer.quality = card.quality
            card_offer.value = card.value
            card_offer.foil = card.foil
            card_offer.card = card.card

            card.card.card_offer << card_offer
          
            trade.reciever_cards << card_offer

          end
      end

      #saving the associations and trade object

      trade.sender_value = sender_value
      trade.reciever_value = reciever_value
      trade.sender = sender
      trade.reciever = reciever

      sender.sent_trades << trade 
      reciever.recieved_trades << trade


      
      trade.save
      flash[:notice] = trade
      flash[:alert] = trade.errors

      redirect_to trade_path(current_user.id)
  end

  def show
      
      @pending_sent_trades = Trade.where(sender_id: current_user.id, reciever_status: "Pending" )
      @pending_recieved_trades = Trade.where(reciever_id: current_user.id, reciever_status: "Pending")


      
      @accepted_sent_trades = Trade.where(sender_id: current_user.id, reciever_status: "Accepted")
      @accepted_recieved_trades = Trade.where(reciever_id: current_user.id, reciever_status: "Accepted")



      @completed_sent_trades = Trade.where(sender_id: current_user.id, reciever_status: "Completed")
      @completed_recieved_trades = Trade.where(reciever_id: current_user.id, reciever_status: "Completed")
      #flash[:notice] = @pending_sent_trades.ids
  end

  def update
    flash[:notice] = params
    trade = Trade.find_by(id: params[:id])
    #figure out whether the current user is the sender or the reciever of the trade
    if (current_user.id == trade.reciever.id)
      curr_user_type = "R"
      other_user = User.find_by(id: trade.sender.id)
    elsif (current_user.id == trade.sender.id)
      curr_user_type = "S"
      other_user = User.find_by(id: trade.reciever.id)
    else
        flash[:alert] = "user somehow tried to update a trade that wasn't theirs"
        redirect_to trade_path(current_user.id)
    end

    #deal with the types of possible updates 
    if params[:commit] == "pending_accepted"
        update_helper(trade, curr_user_type, "Accepted")
        flash[:notice] = "Trade with #{other_user.email} accepted!"
    elsif params[:commit] == "pending_declined"
        update_helper(trade, curr_user_type, "Declined")
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
  elsif c == "S"
    t.update(sender_status: s)
  end
end