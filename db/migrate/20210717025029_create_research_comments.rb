class CreateResearchComments < ActiveRecord::Migration[6.0]
  def change
    create_table :research_comments do |t|
      t.integer :user_id
      t.integer :research_id
      t.text :text
      t.timestamps
    end
  end
end
