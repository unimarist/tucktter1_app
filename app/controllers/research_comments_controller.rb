class ResearchCommentsController < ApplicationController

  def create
    ResearchComment.create(comment_params)
    redirect_to research_research_likes_path(comment_params[:research_id]) 
  end

  private

  def comment_params
    params.require(:research_comment).permit(:text).merge(user_id: current_user.id, research_id: params[:research_id])
  end

end
