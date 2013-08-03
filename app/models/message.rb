class Message < ActiveRecord::Base
  include Rakismet::Model

  attr_accessible :content, :sent_id, :room_id
  rakismet_attrs :content => :content


  belongs_to :owner, class_name: :User,foreign_key: :sent_id
  belongs_to :room
  has_many :message_recipients

  after_create :create_recipients

  def create_recipients
    self.room.members.each do |m|
      if self.sent_id != m.id
        self.message_recipients.create(user_id: m.id)
      else
        self.message_recipients.create(user_id: m.id,status: "seen")
      end
    end
  end

  def read_status user_id
    a = self.message_recipients.find_by_user_id(user_id)
    a.nil? ? "seen" : a.status
  end

end
