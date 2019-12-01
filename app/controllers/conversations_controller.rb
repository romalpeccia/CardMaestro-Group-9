class ConversationsController < ApplicationController
    before_action :authenticate_user!
    before_action do
      #@conversation = Conversation.find(params[:conversation_id])
    end
  
    def index
      @users = User.all
      @conversations = Conversation.all

    
       #needs to be removed TODO
       #@conversation = Conversation.find(params[:id])
       #@messages = @conversation.messages
       #@message = @conversation.messages.new
      
    end

    def show
      @users = User.all
      @conversations = Conversation.all

    
       #needs to be removed TODO
       @conversation = Conversation.find(params[:id])
       @messages = @conversation.messages
       @message = @conversation.messages.new

      render 'index'

    end

    def new_message
      @message = @conversation.messages.new
    end
  
    def create
      if Conversation.between(params[:sender_id], params[:recipient_id]).present?
        @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
      else
        @conversation = Conversation.create!(conversation_params)
      end
      redirect_to conversation_messages_path(@conversation)
    end

    def create_message
      @message = @conversation.messages.new(message_params)
      if @message.save
        redirect_to conversation_messages_path(@conversation)
      end
    end
  
    private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end

    def message_params
      params.require(:message).permit(:body, :user_id)
    end
  end