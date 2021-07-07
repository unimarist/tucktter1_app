class UserController < ApplicationController

  def show
    @nickname = current_user.Nickname
    @tweets = current_user.tweets
  end

end
