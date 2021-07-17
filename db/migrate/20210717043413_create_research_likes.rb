class CreateResearchLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :research_likes do |t|
      t.integer :user_id
      t.integer :research_id
      t.integer :like_count
      t.timestamps
    end
  end
end
