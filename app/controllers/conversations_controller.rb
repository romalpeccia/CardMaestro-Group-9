class ConversationsController < ApplicationController
  
    def index
      @users = User.all
      @conversations = Conversation.all
      
    end

    def show
      @users = User.all
      @conversations = Conversation.all

    
       #needs to be removed TODO
       @conversation = Conversation.find(params[:id])
       @conversation_id = @conversation.id
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
      #redirect_to conversation_messages_path(@conversation)
    end

    def create_message
      
      @conversation = Conversation.find(params[:id])
      @message = @conversation.messages.new(params["/conversations"].permit(:body, :user_id))
    
      if @message.save
        id = @message.id
         redirect_to :controller => 'conversations', :action => 'show', :anchor => id
       end
    end
  
    private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end


    
  end