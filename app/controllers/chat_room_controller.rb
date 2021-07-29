class ChatRoomController < ApplicationController

  def new
    @user = User.find(params[:user_id])
  end

  def create
    binding.pry
    user_id = User.find(params[:user_id])
    chat_room_id = ChatRoom.find(params[:chat_room_id])
    ChatRoom.create(chat_room_params)
    redirect_to user_chat_room_chats_path(user_id,chat_room_id)
  end

  private
  def chat_room_params
    params.require(:chat_room).permit(user_ids: []).merge(room_name: params[:room_name])
  end

end
