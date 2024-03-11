# Manages room resources, including listing, showing, creating, updating, and destroying rooms
class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  # Lists all rooms available in the system
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  # Displays details of a specific room
  def show
  end

  # GET /rooms/new
  # Initializes a new room instance for creation
  def new
    @room = Room.new
  end

  # Searches for rooms based on availability, date, start and end times, and capacity requirements
  def search
    requested_date = Date.parse(params[:date])
    requested_start_time = (Date.new(2000, 01 ,01)+ Time.parse(params[:start]).seconds_since_midnight.seconds).to_datetime
    requested_end_time = (Date.new(2000, 01 ,01)+ Time.parse(params[:end]).seconds_since_midnight.seconds).to_datetime
    seats_left = params[:seats]
    puts requested_date
    puts requested_start_time
    puts requested_end_time
    @rooms = Room.where.not(
      id:Event.where(
        '(? >= start_time AND ? < end_time) OR (? > start_time AND ? <= end_time) OR (? <= start_time AND ? >= end_time)', requested_start_time, requested_start_time, requested_end_time, requested_end_time, requested_start_time, requested_end_time)
              .and(Event.where(date:requested_date)).pluck(:room_id)

    ).and(Room.where("capacity >= ?", seats_left))
    respond_to do |format|
      format.json { render :json => @rooms }
    end
  end

  # GET /rooms/1/edit
  # Prepares a room for editing
  def edit
  end

  # POST /rooms or /rooms.json
  # Creates a new room with the specified parameters and handles the response based on the operation's success or failure
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to room_url(@room), notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  # Updates an existing room's details and handles the response based on the operation's success or failure
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  # Deletes a room and confirms the successful deletion to the user
  def destroy
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:location, :capacity)
    end
end
