class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.string :text
      t.references :chat_room, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
