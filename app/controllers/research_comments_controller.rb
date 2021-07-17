class ResearchCommentsController < ApplicationController

  before_action :return_index

  def create
    ResearchComment.create(comment_params)
    redirect_to research_research_likes_path(comment_params[:research_id]) 
  end

  private

  def return_index
    unless user_signed_in?
      redirect_to "/"
    end
  end

  def comment_params
    params.require(:research_comment).permit(:text).merge(user_id: current_user.id, research_id: params[:research_id])
  end

end
