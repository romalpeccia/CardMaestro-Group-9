class CollectionsController < ApplicationController
  def show
    # @collection_card_owned = User.find(params[:id]).card_owned.map { |row| row.card }
    user_id = current_user.id
    target_id = params[:id].to_i
    @is_self = false
    @collection_error = false

    @target_user = User.find_by(id: target_id)
    if @target_user
      @target_email = @target_user.email
      @collection_card_owned = @target_user.card_owned
      @collection_card_needed = @target_user.card_needed
      if target_id == current_user.id
        @is_self = true;
      end
=begin
      if target_id == current_user.id
        @is_self = true;
      else
        user = User.find_by(id: user_id)
        card_owned_ids = user.card_owned.map { |row| row.card_id }
        card_needed_ids = user.card_needed.map { |row| row.card_id }
        @collection_card_owned = card_needed_ids.collect { |id| @collection_card_owned.find_by(card_id: id)}.compact
        @collection_card_needed = card_owned_ids.collect { |id| @collection_card_needed.find_by(card_id: id)}.compact
      end
=end
    else
      flash.now[:alert] = "user not found"
      @collection_error = true
    end
  end
end
