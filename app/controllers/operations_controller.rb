class OperationsController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    user = User.find(params[:id])
    user.student_or_coach = "coach"
    user.save
    redirect_to operations_path
  end

end
