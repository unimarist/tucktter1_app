class Research < ApplicationRecord
  validates :research_title,:research_summary,:research_url presence: true
  belongs_to :user
end
