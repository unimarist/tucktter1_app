class ChatRoom < ApplicationRecord
  has_many :chats_messages
  has_many :room_users
  has_many :users, through: :room_users
end
