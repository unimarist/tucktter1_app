class Research < ApplicationRecord
  validates :research_url,presence: true
  validates :research_title,presence: true,length: { maximum: 50 }
  validates :research_summary,presence: true,length: { maximum: 500 }
  belongs_to :user
end
