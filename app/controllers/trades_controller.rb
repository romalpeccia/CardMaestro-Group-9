
require 'paypal-sdk-rest'
require 'securerandom'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class TradesController < ApplicationController
  protect_from_forgery :except => [:payment]
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
        card_owned_ids = user.card_owned
        card_needed_ids = user.card_needed
        @collection_card_owned = card_needed_ids.map { |card| @collection_card_owned.find_by(card_id: card.card_id, quality: card.quality, foil: card.foil)}.compact
        @collection_card_needed = card_owned_ids.map { |card| @collection_card_needed.find_by(card_id: card.card_id, quality: card.quality, foil: card.foil)}.compact
        end
      else
        flash[:alert] = "user not found"
        @collection_error = true
      end

      
      render 'new'
  end
  def create
      @target_user = User.find_by(id: params[:reciever_id])
      if (params[:sender_value] != 0 and params[:reciever_value]  != 0) and (params[:sender_value] != "" and params[:reciever_value]  != "")
        flash[:alert] = "You cannot send and recieve money in the same trade"
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
        if s_v < 0 or r_v < 0 #UI should stop user from doing this unless they are trying to cheat the post request
          flash[:alert] = "Error: Cannot trade negative money"
          redirect_to new_trade_path(id: @target_user.id)
        else
          #flash[:notice] = params

          sender = User.find_by(id: params[:sender_id]) 
          reciever = User.find_by(id: params[:reciever_id])


          trade = PendingTrade.new(sender_status: "Accepted", reciever_status: "Pending")
          no_card_flag = 1
          params.each do |key, value|
              if key.include? "card_owned" 
                no_card_flag = 0
                card_collection = CardOwned.find_by(id: value)
                card_wishlist = CardNeeded.find_by(user_id: sender.id, card_name: card_collection.card_name, quality: card_collection.quality, foil: card_collection.foil, card: card_collection.card)


                trade.reciever_cards << card_collection
                trade.sender_wishlist_cards << card_wishlist
              elsif key.include? "card_needed"
                no_card_flag = 0
                card_wishlist = CardNeeded.find_by(id: value)
                card_collection = CardOwned.find_by(user_id: sender.id, card_name: card_wishlist.card_name, quality: card_wishlist.quality, foil: card_wishlist.foil, card: card_wishlist.card)
                #save card to list of sender_cards (cards the sender will send)
                trade.sender_cards << card_collection
                trade.reciever_wishlist_cards << card_wishlist

                #save card to list of sender_card_neededs (cards the reciever had on their wishlist)
                

              end
          end
          if no_card_flag == 1
            flash[:alert] = "Error: Select at least one card"
            redirect_to new_trade_path(id: @target_user.id)
          else
            trade.sender_value = s_v
            trade.reciever_value = r_v
            trade.sender = sender
            trade.reciever = reciever
    
            sender.sent_pending_trades << trade 
            reciever.recieved_pending_trades << trade
    
    
              #saving the associations and trade object
            trade.save
            #for debugging
            #flash[:notice] = trade
            #flash[:alert] = trade.errors
            redirect_to trade_path(current_user.id)
          end #end if no cards were selected
        end #end if sender and reciever values were nonnegative
      end #end if sender AND reciever values are both inputted
      
  end

  def show
      
      #sender_status is by default "Accepted" 
        #trades the current user sent, waiting for reciever to change status to accepted
      @pending_sent_trades = PendingTrade.where(sender_id: current_user.id, reciever_status: "Pending" )
        #trades the current user recieved, waiting for current user to change status to accepted
      @pending_recieved_trades = PendingTrade.where(reciever_id: current_user.id, reciever_status: "Pending")

        

      #@accepted_sent_trades = Trade.where(sender_id: current_user.id , reciever_status: "Accepted").or(Trade.where(sender_id: current_user.id , sender_status: "Accepted"))
      #@accepted_recieved_trades = Trade.where(reciever_id: current_user.id , reciever_status: "Accepted").or(Trade.where(reciever_id: current_user.id , sender_status: "Accepted"))

      all_curr_user_trades = Trade.where(sender_id: current_user.id).or(Trade.where(reciever_id: current_user.id))
      #get all trades where neither person has completed
      #get all trades where user is the one not completed
      #get all trades where the user is waiting for the other person to complete
      @accepted_trades = all_curr_user_trades.where(reciever_status: "Accepted", sender_status: "Accepted").or(all_curr_user_trades.where(reciever_status: "Completed", sender_status: "Accepted")).or(all_curr_user_trades.where(reciever_status: "Accepted", sender_status: "Completed"))




      @completed_trades = Trade.where(sender_id: current_user.id, reciever_status: "Completed", sender_status: "Completed").or(Trade.where(reciever_id: current_user.id, reciever_status: "Completed", sender_status: "Completed"))
      #@completed_recieved_trades = Trade.where(reciever_id: current_user.id, reciever_status: "Completed", sender_status: "Completed")

  end

  def update
    if params[:commit] == "pending_accepted" or params[:commit] == "pending_declined"
      trade = PendingTrade.find_by(id: params[:id])
    elsif params[:commit] == "accepted_completed"
      trade = Trade.find_by(id: params[:id])
    end
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
        
        updated_trade = Trade.new(reciever_status: trade.reciever_status, sender_status: trade.sender_status, sender_value: trade.sender_value, reciever_value: trade.reciever_value, sender: trade.sender, reciever: trade.reciever)
        trade.sender_cards.each do |card|
            card_offer = CardOffer.new
            card_offer.card_name = card.card_name
            card_offer.quality = card.quality
            card_offer.value = card.value
            card_offer.foil = card.foil
            card_offer.card = card.card
            
            #card.card.card_offer << card_offer
            updated_trade.sender_cards << card_offer
            card.delete
        end
        trade.reciever_cards.each do |card|
          card_offer = CardOffer.new
          card_offer.card_name = card.card_name
          card_offer.quality = card.quality
          card_offer.value = card.value
          card_offer.foil = card.foil
          card_offer.card = card.card
          
          #card.card.card_offer << card_offer
          
          updated_trade.reciever_cards << card_offer
          card.delete
        end
        trade.sender_wishlist_cards.each do |card|
          card.delete
        end
        trade.reciever_wishlist_cards.each do |card|
          card.delete
        end
        updated_trade.sender.sent_trades << updated_trade 
        updated_trade.reciever.recieved_trades << updated_trade
 
    elsif params[:commit] == "pending_declined" #dont delete the trade for now, we may want to display declined trades
        #TODO fix edge case where user can cancel an accepted trade if the other person accepts and you havent refreshed
        update_helper(trade, "R", "Declined")
        update_helper(trade, "S", "Declined")
        flash[:alert] = "Trade with #{other_user.email} declined!"
    elsif params[:commit] == "accepted_completed"
        update_helper(trade, curr_user_type, "Completed")
        flash[:notice] = "Trade with #{other_user.email} confirmed!"
    else 
      flash[:alert] = "Error updating trade"
    end
    
    redirect_to trade_path(current_user.id)
  end


  def payment_from_user
    puts params[:orderID]+" has completed to user: "+params[:userEmail]
    payment_to_user(params[:userEmail], params[:value])
    render status: :ok, json: @controller.to_json
  end

  def payment_to_user(email, amount_to_send)
    # will send to sb-takox644531@personal.example.com for testing purpose, regardless of input email address
    @payout = Payout.new(
    {
      :sender_batch_header => {
        :sender_batch_id => SecureRandom.hex(8),
        :email_subject => 'You have a Payout!',
      },
      :items => [
        {
          :recipient_type => 'EMAIL',
          :amount => {
            :value => amount_to_send.to_s,
            :currency => 'USD'
          },
          :note => 'Thanks for your patronage!',
          :receiver => email
          # :sender_item_id => "2014031400023",
        }
      ]
    }
  )

  begin
    @payout_batch = @payout.create
    logger.info "Created Payout with [#{@payout_batch.batch_header.payout_batch_id}]"
  rescue ResourceNotFound => err
    logger.error @payout.error.inspect
  end
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
