class UserController < ApplicationController

  def show
    @nickname = current_user.Nickname
    @tweets = current_user.tweets.order(created_at: :desc)
    @tweet = Tweet.new
  end

end
