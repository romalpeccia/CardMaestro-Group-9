class CollectionsController < ApplicationController
  def show
    # @collection_card_owned = User.find(params[:id]).card_owned.map { |row| row.card }
    @collection_card_owned = User.find(params[:id]).card_owned
    @collection_card_needed = User.find(params[:id]).card_needed
  end
end
