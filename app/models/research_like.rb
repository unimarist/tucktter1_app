class ResearchLike < ApplicationRecord
  belongs_to :user
  belongs_to :research
  validates_uniqueness_of :research_id, scope: :user_id
end
