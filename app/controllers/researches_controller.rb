class ResearchesController < ApplicationController
  before_action :set_research, only: [:edit, :show]

  def index
    @researchs = Research.all
  end

  def new
    @research = Research.new
  end

  def create
    Research.create(research_params)
  end

  private
  def research_params
    params.require(:research).permit(:research_title,:research_summary,:research_url,:research_status).merge(user_id:current_user.id)
  end

  def set_research
    @research = Research.find(params[:id])
  end

end
