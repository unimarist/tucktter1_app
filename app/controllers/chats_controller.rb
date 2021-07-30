class ChatsController < ApplicationController
  def index
    binding.pry
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @chat = Chat.new
    @chats = @chat_room.chats.includes(:user)
  end
end
