class ResearchCommentsController < ApplicationController

  def create
    Comment.create(comment_params)
    redirect_to "/researchs/#{comment_params[:research_id]}"
  end

  private

  def comment_params
    params.require(:research_comment).permit(:text).merge(user_id: current_user.id, research_id: params[:research_id])
  end

end
