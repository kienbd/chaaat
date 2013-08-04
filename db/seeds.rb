# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all
Room.delete_all
Message.delete_all
MessageRecipient.delete_all
UserRoomRelationship.delete_all

def make_users
  10.times do |n|
    username  = Faker::Name.name
    email = "user#{n+1}@gmail.com"
    password  = "123456789"
    u = User.create(username:     username,
     email:    email,
     password: password,
     password_confirmation: password,
     location: Faker::Address.city)
    u.save
  end
  puts 'make users'
end

make_users

puts 'seed completed'
