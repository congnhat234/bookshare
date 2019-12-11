class Dashboard::ConversationsController < ApplicationController
  layout "dashboard/application"
  def index
    session[:conversations] = params[:id]
    @users = current_user.following
    @conversations = Conversation.user_conversations(current_user)
    @conversation = Conversation.find_by(id: session[:conversations])
    if @conversation && (current_user.id == @conversation.sender_id)
      @conversation.update_attributes(sender_read: true)
    end
    if @conversation && (current_user.id == @conversation.recipient_id)
      @conversation.update_attributes(recipient_read: true)
    end
  end

  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])
    session[:conversations] = @conversation.id
    redirect_to dashboard_conversations_path
  end
end
