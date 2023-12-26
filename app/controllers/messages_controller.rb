class MessagesController < ApplicationController
  before_action :authenticate_user!

  def authenticate_user!
    redirect_to new_user_session_path unless current_user
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.new(message_params) 
    @message.user = current_user

    binding.pry

    if @message.save 
      redirect_to chat_path(@chat)
    else 
      flash[:error] = @message.errors.full_messages
      Rails.logger.error flash[:error]
      render 'chats/show',  status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
