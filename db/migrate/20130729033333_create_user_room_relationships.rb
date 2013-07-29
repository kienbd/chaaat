class CreateUserRoomRelationships < ActiveRecord::Migration
  def change
    create_table :user_room_relationships do |t|
      t.integer :user_id
      t.integer :room_id
      t.boolean :admin,default: false

      t.timestamps
    end
  end
end
