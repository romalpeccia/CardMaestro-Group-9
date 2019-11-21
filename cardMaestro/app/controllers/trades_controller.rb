class TradesController < ApplicationController
  def new
      @user2 = params[:user2]
      flash[:notice] = params
      render 'new'
  end
end
