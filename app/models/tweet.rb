class Tweet < ApplicationRecord
  validates :tweet, presence: true
  belongs_to :user
  has_many :comments
  has_many :tweet_likes
end
