class ResearchLikesController < ApplicationController
  before_action :set_research, only: :index

  def index
    @like = ResearchLike.new  
    @likes = @research.research_likes.includes(:user)  
  end

  def create
    current_user.research_likes.create(research_id: params[:research_id])
    redirect_to research_research_likes_path(params[:research_id]) 
  end

  def destroy
    @like = ResearchLike.find_by(research_id: params[:research_id], user_id: current_user.id)
    @like.destroy
    redirect_to research_research_likes_path(params[:research_id]) 
  end

  private

  def set_research
    @research = Research.find(params[:research_id])
  end

end
