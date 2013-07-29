class Message < ActiveRecord::Base
  attr_accessible :content, :sent_id, :room_id

  validates :content, length: {maximum: 150}

  belongs_to :owner, class_name: :User,foreign_key: :sent_id
  belongs_to :room
  has_many :message_recipients

end
