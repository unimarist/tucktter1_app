class ChatRoomController < ApplicationController

  def new
    @chat_room = ChatRoom.new
    @comment = Comment.find(params[:comment_id])
    @commenter = @comment.user.Nickname
  end

end
