class RemoveLikeCountFromResearchLike < ActiveRecord::Migration[6.0]
  def change
    remove_column :research_likes, :like_count, :integer
  end
end
