class ResearchLikesController < ApplicationController
  def create
    Researchlike.create(like_params)
    redirect_to research_path(like_params[:research_id]) 
  end

  private

  def like_params
    params.require(:research_like).merge(user_id: current_user.id, research_id: params[:research_id])
  end

end
