class ResearchCommentsController < ApplicationController
  before_action :set_research, only: :index
  before_action :return_index, except: :index 

  def index
  @comment = ResearchComment.new
  @comments = @research.research_comments.includes(:user)
  end  

  def create
    ResearchComment.create(comment_params)
    redirect_to research_research_comments_path(comment_params[:research_id]) 
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

  def set_research
    @research = Research.find(params[:research_id])
  end

end
