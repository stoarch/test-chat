class ChatsController < ApplicationController
  def index 
    @chats = Chat.all
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save 
      redirect_to chats_path
    else 
      render :new
    end
  end

  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages
    @message = Message.new
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end
end
