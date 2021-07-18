class TweetLikesController < ApplicationController
  before_action :set_tweet, only: :index
  before_action :return_index, except: [:index]

  def index 
    @likes = @tweet.tweet_likes.includes(:user)  
  end

  def create  
    current_user.tweet_likes.create(tweet_id: params[:tweet_id])
    flash[:result] = "+1 いいね！" 
    redirect_to  tweet_tweet_likes_path(params[:tweet_id])
  end

  def destroy
    @like = TweetLike.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    @like.destroy
    flash[:result_del] = "-1 いいね取消" 
    redirect_to  tweet_tweet_likes_path(params[:tweet_id])
  end

  private

  def return_index
    unless user_signed_in?
      redirect_to "/"
    end
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

end
