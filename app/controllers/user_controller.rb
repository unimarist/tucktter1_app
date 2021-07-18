class UserController < ApplicationController

  before_action :return_index

  def show
    @nickname = current_user.Nickname
    @tweets = current_user.tweets.order(created_at: :desc)
    @tweet = Tweet.new
  end

  private

  def return_index
    unless user_signed_in?
      redirect_to "/"
    end
  end

end
