class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets,dependent: :destroy
  has_many :researches,dependent: :destroy
  has_one_attached :user_icon,dependent: :destroy
  has_one_attached :user_identification,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :research_comments,dependent: :destroy
  has_many :research_likes,dependent: :destroy
  has_many :tweet_likes,dependent: :destroy
  has_many :room_users
  has_many :chat_rooms, through: :room_users
  has_many :chats
  validates :Nickname, presence: true,uniqueness: true,length: { maximum: 15 }
  validates :password, length: { maximum: 30 }
  validates :password_confirmation, length: { maximum: 30 }
  validates :hobby, length: { maximum: 100 }
  validates :aWord, length: { maximum: 100 }

  def already_liked?(research)
    self.research_likes.exists?(research_id: research.id)
  end

  def tweet_already_liked?(tweet)
    self.tweet_likes.exists?(tweet_id: tweet.id)
  end


end
