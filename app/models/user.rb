class User < ActiveRecord::Base
  attr_accessible :avatar, :email, :gender, :location, :username,:password,:password_confirmation

  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_save :create_persistence_token

  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

  validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_many :sent_messages,class_name: :Message,foreign_key: :sent_id
  has_many :rooms,class_name: :Room,foreign_key: :owner_id
  has_many :user_room_relationships
  has_many :recipients,class_name: :MessageRecipient,foreign_key: :user_id
  has_many :unseen_recipients,class_name: :MessageRecipient,foreign_key: :user_id,conditions: {status: "unseen"}
  has_many :received_messages,through: :recipients,source: :message
  has_many :unseen_messages,through: :unseen_recipients,source: :message
  has_many :access,through: :user_room_relationships,source: :room


  mount_uploader :avatar, AvatarUploader

  def avatar_url
    self.avatar.url.nil? ? "default_avatar.jpg" : self.avatar.url
  end

  def all_messages_in_room room_id
    self.received_messages.where("room_id = ? ", room_id)
  end

  def recent_messages_in_room room_id
    self.received_messages.where("room_id = ? ", room_id).last(50)
  end

  def unseen_messages_in_room room_id
    self.unseen_messages.where("room_id = ? ", room_id)
  end

  def read_in_room room_id
    self.unseen_messages_in_room(room_id).each do |m|
      m.message_recipients.where("user_id = ?",self.id).each { |r| r.update_attributes(status: "seen") }
    end
  end

  def has_p2p_room? user_id
    Room.where(owner_id: [self.id,user_id]).keep_if{|m| ([self.id,user_id]-m.member_ids).empty?}.first
  end

  def online?
    updated_at > 1.minutes.ago
  end

  def has_access? room_id
    self.acces_ids.include?(room_id)
  end

  private

  def create_persistence_token
    self.persistence_token = SecureRandom.urlsafe_base64
  end

end
