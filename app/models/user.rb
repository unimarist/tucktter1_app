class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets,dependent: :destroy
  has_many :researches,dependent: :destroy
  has_one_attached :user_icon
  has_one_attached :user_identification
  has_many :comments
  has_many :research_comments
  has_many :research_likes
  has_many :tweet_likes
  validates :Nickname, presence: true

  def already_liked?(research)
    self.research_likes.exists?(research_id: research.id)
  end


end
