class CommentsController < ApplicationController
  
  before_action :set_tweet, only: :index
  before_action :return_index, except: :index 

  def index
  @comment = Comment.new
  @comments = @tweet.comments.includes(:user)
  end  

  def create
    Comment.create(comment_params)
    redirect_to tweet_comments_path(comment_params[:tweet_id]) 
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

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

end