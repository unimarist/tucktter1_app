class UserController < ApplicationController

  before_action :return_index

  def show
    @user = User.find(params[:id])
    @tweets = User.find(params[:id]).tweets.order(created_at: :desc)
    @tweet = Tweet.new
  end

  def edit
    @coach = User.find(params[:id])
  end

  def update
    
    if coach_params[:FirstName].blank? || coach_params[:LastName].blank? || coach_params[:user_identification].blank? || coach_params[:university].blank? || coach_params[:department].blank? || coach_params[:major].blank?
      redirect_to edit_user_path(current_user.id),flash: {error_coach: "各項目の入力は必須です。"}
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
    params.require(:user).permit(:FirstName,:LastName,:user_icon,:university,:department,:major,:user_identification,:Nickname,:email)
  end


end
