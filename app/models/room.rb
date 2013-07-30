class Room < ActiveRecord::Base
  attr_accessible :name,:owner_id

  belongs_to :owner,class_name: :User,foreign_key: :owner_id

  has_many :user_room_relationships
  has_many :members,through: :user_room_relationships,source: :user
  has_many :messages

  validates :name,length: {within: 2..128}

  after_create :add_owner_to_member

  def add_owner_to_member
    self.user_room_relationships.create(user_id: self.owner_id,admin: true)
  end

  def add_member user_id
    self.user_room_relationships.create(user_id:user_id)
  end

  def remove_member user_id
    self.user_room_relationships.find_by_user_id(user_id).destroy
  end

  def toggle_admin user_id
    self.user_room_relationships.find_by_user_id(user_id).toggle!(:admin)
  end

  def is_admin? user_id
    self.user_room_relationships.find_by_user_id(user_id).admin
  end

  def is_member? user_id
    self.members.map{|m| m.id}.include? user_id
  end

  def is_owner? user_id
    self.owner_id == user_id
  end

end
