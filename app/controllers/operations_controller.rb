class OperationsController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    puts params[:id]
    redirect_to root_path
  end

end
