class CommentsController < ApplicationController
  
  before_action :return_index

  def create
    Comment.create(comment_params)
    redirect_to "/tweets/#{comment_params[:tweet_id]}"
  end

  private

  def return_index
    unless user_signed_in?
      redirect_to "/"
    end
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end



end
