class UserController < ApplicationController

  before_action :return_index

  def show
    @nickname = current_user.Nickname
    @tweets = current_user.tweets.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def edit
    @coach = User.find(params[:id])
  end

  def update
    if coach_params[:FirstName].blank? || coach_params[:LastName].blank? || coach_params[:user_identification].blank? || coach_params[:university].blank? || coach_params[:department].blank? || coach_params[:major].blank?
      flash.now[:error_coach] = "各項目の入力は必須です。"
      render :edit
    else
      @coach = User.find(params[:id]) 
      @coach.update(coach_params)
    end
  end

  private

  def return_index
    unless user_signed_in?
      redirect_to "/"
    end
  end

  def coach_params
    params.permit(:FirstName,:LastName,:user_icon,:university,:department,:major,:user_identification)
  end


end
