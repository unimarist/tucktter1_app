class ChatsController < ApplicationController
  def index
    binding.pry
    @room_name = ChatRoom.find(params[:room_name])
    @chat = Chat.new
    @chats = @room_name.chats.include(:user)
  end
end
