class MessagesController < ApplicationController
  before_action :authenticate_user!

  def authenticate_user!
    redirect_to new_user_session_path unless current_user
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.new(message_params) 
    @message.user = current_user

    if @message.save
      Rails.logger.debug "Broadcasting with: #{render_message(@message)}"

      ActionCable.server.broadcast "chat_#{@chat.id}", {user: current_user.id, message: render_message(@message)}

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('messages', partial: 'messages/message', locals: { message: @message })
        end
        format.html { redirect_to @chat }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@message, partial: 'form', locals: { message: @message }), status: :unprocessable_entity
        end
        format.html { render 'chats/show', status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
