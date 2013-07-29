class Message < ActiveRecord::Base
  attr_accessible :content, :sent_id, :room_id

  belongs_to :owner, class_name: :User,foreign_key: :sent_id
  belongs_to :room
  has_many :message_recipients

  after_create :create_recipients

  def create_recipients
    self.room.members.each do |m|
      self.message_recipients.create(user_id: m.id)
    end
  end

end
