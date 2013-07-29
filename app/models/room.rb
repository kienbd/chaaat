class Room < ActiveRecord::Base
  attr_accessible :name,:owner_id

  belongs_to :owner,class_name: :User,foreign_key: :owner_id

  has_many :user_room_relationships
  has_many :members,through: :user_room_relationships,source: :user
  has_many :messages

  validates :name,length: {within: 2..128}

end
