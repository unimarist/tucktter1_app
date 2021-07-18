class ResearchComment < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  belongs_to :research
end
