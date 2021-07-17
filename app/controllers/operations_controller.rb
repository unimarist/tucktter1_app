class OperationsController < ApplicationController

  before_action :return_index

  def index
    @users = User.all
  end

  def edit
    user = User.find(params[:id])
    user.student_or_coach = "coach"
    user.save
    redirect_to operations_path
  end

  private

  def return_index
    unless user_signed_in?
      redirect_to "/"
    end
  end

end
