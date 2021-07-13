class UserController < ApplicationController

  def show
    @nickname = current_user.Nickname
    @tweets = current_user.tweets.order(created_at: :desc)
  end

end
