class CreateResearches < ActiveRecord::Migration[6.0]
  def change
    create_table :researches do |t|
      t.integer :user_id
      t.string :research_title
      t.text :research_summary
      t.text :research_url
      t.string :research_status
      t.timestamps
    end
  end
end
