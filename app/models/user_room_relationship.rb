class UserRoomRelationship < ActiveRecord::Base
  attr_accessible :admin, :room_id, :user_id

  belongs_to :room
  belongs_to :user
end
