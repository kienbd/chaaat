class User < ActiveRecord::Base
  attr_accessible :avatar, :email, :gender, :location, :name,:password,:password_confirmation

  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_save :create_persistence_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}

  validates :password, presence: true, length: { minimum: 6 }, on: :create


  mount_uploader :avatar, AvatarUploader


  private

  def create_persistence_token
    self.persistence_token = SecureRandom.urlsafe_base64
  end
end
