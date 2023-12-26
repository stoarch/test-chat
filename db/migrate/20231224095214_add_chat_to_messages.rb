class AddChatToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :chat, null: false, foreign_key: true
  end
end
