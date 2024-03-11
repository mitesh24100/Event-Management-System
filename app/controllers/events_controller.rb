# Manages event actions, including listing, showing, creating, updating, and destroying events, with authorization check
class EventsController < ApplicationController
  include EventsHelper
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authorized
  # GET /events or /events.json
  # Filters and lists events based on parameters like category, date, price, and event name; shows all or upcoming events based on user role
  def index

    @category = params[:category]
    @date = params[:date]
    @price_min = params[:price_min]
    @price_max = params[:price_max]
    @event_name = params[:event_name]

    # Query your events based on the provided parameters
    if current_user.admin?
      if @category.present? && @date.present? && @price_max.present? && @price_min.present? && @event_name.present?
        @events = Event.where(category: @category)
                       .where(date: @date)
                       .where('ticket_price >= ?', @price_min)
                       .where('ticket_price <= ?', @price_max)
                       .where('name LIKE ?', "%#{@event_name}%")
      else
        @events = Event.all
      end
    else
      if @category.present? && @date.present? && @price_max.present? && @price_min.present?
        @events = Event.where(category: @category)
                       .where(date: @date)
                       .where('ticket_price >= ?', @price_min)
                       .where('ticket_price <= ?', @price_max)
                       .where("date >= ?", Date.today)
                       .where("seats_left > 0")
      elsif @event_name.present?
        @events = Event.where('name LIKE ?', "%#{@event_name}%")

      else
        @events = Event.where("date >= ?", Date.today).where("seats_left > 0")
      end

      #@events = Event.where("date >= ?", Date.today).where("seats_left > 0")
    end

    # Fetch upcoming events separately
    @upcoming_events = Event.where("date >= ?", Date.today).where("seats_left > 0")
  end

  # GET /events/1 or /events/1.json
  # Displays detailed information for a specific event
  def show
  end

  # GET /events/new
  # Initializes a new event instance for the creation form
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  # Prepares an event for editing
  def edit
  end

  # POST /events or /events.json
  # Creates a new event with parameters from the form, including calculating seats left from room capacity
  def create
    # event_params[:start_time] = parse_time(event_params[:start_time])
    # event_params[:end_time] = parse_time(event_params[:end_time])
    room = Room.find(event_params[:room_id])
    seats_left = room.capacity
    event_params_with_capacity = event_params.merge(seats_left: seats_left)
    @event = Event.new(event_params_with_capacity)
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # def parse_time(time_string)
  #   # Parse time string and return only the time component: event time was being saved with random date even tho its "time" datatype
  #   Time.parse(time_string).strftime("%H:%M:%S")
  # end
  # PATCH/PUT /events/1 or /events/1.json

  # Updates an existing event's attributes and redirects or renders form based on success or failure
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  # Deletes an event and notifies the user of successful destruction
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Searches for attendees of a specific event by event name and displays them
  def search_attendees
    @event_name = params[:event_name]
    event = Event.find_by(name: @event_name)
    @attendees = User.joins(:tickets).where(tickets: { event_id: event.id }).distinct if event
    render "events/searchuser"
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Finds and sets an event based on the event id for actions requiring an id.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :category, :date, :start_time, :end_time, :ticket_price, :room_id)
  end
end
