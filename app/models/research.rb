class Research < ApplicationRecord
  validates :research_url,presence: true
  validates :research_title,presence: true,length: { maximum: 50 }
  validates :research_summary,presence: true,length: { maximum: 500 }
  belongs_to :user

  def self.search(search_key)
      Research.where('research_title LIKE(?)', "%#{search_key}%")
  end 

  def self.my_search(search_key,current_user_id)
    Research.where('research_title LIKE(?)', "%#{search_key}%").where('user_id LIKE(?)', "%#{current_user_id}%")
end 

end
