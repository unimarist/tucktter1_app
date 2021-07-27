class ChatRoomController < ApplicationController

  def new
    @chat_room = ChatRoom.new
    @user = User.find(params[:user_id])
  end

end
