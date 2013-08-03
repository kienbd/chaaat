class RoomsController < ApplicationController
  # GET /rooms
  # GET /rooms.json

  before_filter :signed_in_user
  before_filter :user_has_access,only: [:show]
  def index
    # @rooms = Room.all
    store_hostname
    @rooms = current_user.access
    @unseens = current_user.unseen_messages

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rooms }
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    store_hostname
    @room = Room.find(params[:id])
    @messages = current_user.recent_messages_in_room @room.id
    @unseens = current_user.unseen_messages_in_room @room.id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @room }
    end
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render json: @room, status: :created, location: @room }
      else
        format.html { render action: "new" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
      format.json { head :no_content }
    end
  end

  def add_member
    @room = Room.find(params[:room_id])
    @room.add_member(params[:user_id])

    respond_to do |format|
      format.js
    end
  end


  def create_p2p
    @user1 = params[:user1_id]
    @user2 = params[:user2_id]
    id = Room.count + 1
    @room = Room.create(name: "Room\##{id}",owner_id: params[:user1_id])
    @room.save
    @room.add_member(params[:user2_id])
    @room.toggle_admin(params[:user2_id])

    respond_to do |format|
      format.html {redirect_to @room}
      format.js
    end
  end


  def remove_member
    @room = Room.find(params[:room_id])
    @room.remove_member(params[:user_id])

    respond_to do |format|
      format.js
    end
  end

  def toggle_admin
    @room = Room.find(params[:room_id])
    @room.toggle_admin(params[:user_id])

    respond_to do |format|
      format.js
    end
  end


  def drop_room
    @room = Room.find(params[:id])
    @room.user_room_relationships.find_by_user_id(current_user.id).destroy

    respond_to do |format|
      format.html { redirect_to rooms_url }
    end

  end

  def user_has_access
    redirect_to root_path unless current_user.has_access?(params[:id].to_i)
  end

end
