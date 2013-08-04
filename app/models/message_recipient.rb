class MessageRecipient < ActiveRecord::Base
  attr_accessible :message_id, :status, :user_id


  belongs_to :message
  belongs_to :user

end
