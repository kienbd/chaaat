class CreateMessageRecipients < ActiveRecord::Migration
  def change
    create_table :message_recipients do |t|
      t.integer :message_id
      t.integer :user_id
      t.string :status, default: "unseen"

      t.timestamps
    end
  end
end
