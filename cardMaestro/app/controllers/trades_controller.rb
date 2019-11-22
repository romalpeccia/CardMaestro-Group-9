class TradesController < ApplicationController
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
      flash[:notice] = params
      reciever_id = params[:reciever_id]
      sender_id = params[:sender_id]
      sender_value = 0
      reciever_value = 0
      params.each do |key, value|
          if key.include? "card_owned" 
            card = CardOwned.find_by(id: value)
            sender_value = sender_value + card.value
          elsif key.include? "card_needed"
            card = CardNeeded.find_by(id: value)
            reciever_value = reciever_value + card.value
          end
      end
      trade_value = sender_value - reciever_value
      puts trade_value
      render 'trade_list'
  end
end
