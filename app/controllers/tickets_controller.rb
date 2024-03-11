# Manages ticket operations including booking history, listing, creating, updating, and destroying tickets with authorization checks
class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  before_action :authorized

  # Compiles a history of tickets both purchased by and received by the current user
  def booking_history
    purchased_tickets = Ticket.where(user_id: current_user.id)
    received_tickets = Ticket.where(purchased_for_user_id: current_user.id)
    @tickets = purchased_tickets + received_tickets
  end
  # GET /tickets or /tickets.json
  # Lists all tickets for an admin user, or only those associated with the current user for non-admins
  def index
    if current_user.admin?
      @tickets = Ticket.all
    else
      @tickets = Ticket.where(user_id: current_user.id)
    end
  end

  # GET /tickets/1 or /tickets/1.json
  # Displays details of a specific ticket.
  def show
  end

  # GET /tickets/new
  # Initializes a new ticket instance and ensures the associated event exists, or redirects with an alert if not found
  def new
    @ticket = Ticket.new

    begin
      @event = Event.find(params[:event_id])
      #@ticket = @event.tickets.build
    rescue ActiveRecord::RecordNotFound
      redirect_to events_path, alert: "Event not found."
    end
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  # Creates a new ticket with generated confirmation number, calculates total price, updates event seats, and handles booking logic
  def create

    event = Event.find(ticket_params[:event_id])
    room_id = event.room_id
    user_id = session[:user_id]
    confirmation_number = Array.new(10){[*"A".."Z",*"0".."9"].sample}.join
    #@ticket = @event.tickets.build(ticket_params)
    #@ticket.user_id = current_user.id # Associate ticket with current user
    price = event.ticket_price
    total_price = event.ticket_price * ticket_params[:number_of_tickets].to_i

    ticket_param = ticket_params.merge(room_id: room_id)
    ticket_param = ticket_param.merge(user_id: user_id)
    ticket_param = ticket_param.merge(confirmation_number: confirmation_number)
    ticket_param = ticket_param.merge(price: price)
    ticket_param = ticket_param.merge(total_price: total_price)

    @ticket = Ticket.new(ticket_param)
    if params[:purchased_for_user_id].present?
      @ticket.purchased_for_user_id = params[:purchased_for_user_id]
    end

    # Check if enough seats are available
    if event.seats_left >= ticket_params[:number_of_tickets].to_i && @ticket.save
      # Update the event's number of seats left
      event.update(seats_left: event.seats_left - ticket_params[:number_of_tickets].to_i)

      # Redirect with success message including total price
      redirect_to @ticket, notice: "Ticket booked successfully. Total Price: $#{@ticket.total_price}"
    else
      # Handling for not enough seats or other save failures
      render :new, notice: 'Could not book the ticket. Not enough seats available or invalid data.'
    end
  end



  # PATCH/PUT /tickets/1 or /tickets/1.json
  # Updates an existing ticket, recalculates the total price based on the new number of tickets, and adjusts the event's available seats accordingly
  def update
    event = @ticket.event # Assuming Ticket belongs_to :event
    old_number_of_tickets = @ticket.number_of_tickets

    respond_to do |format|
      if @ticket.update(ticket_params)
        new_number_of_tickets = @ticket.number_of_tickets
        new_price_of_ticket = event.ticket_price * new_number_of_tickets.to_i
        @ticket.update(total_price: new_price_of_ticket)
        # Adjust the event's seats_left based on the change in ticket numbers
        change_in_tickets = old_number_of_tickets - new_number_of_tickets
        event.update(seats_left: event.seats_left + change_in_tickets)

        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated. Seats and price have been updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  # Deletes a ticket and updates the associated event's available seats
  def destroy
    event = @ticket.event # Assuming Ticket belongs_to :event
    # Increase the event's seats_left by the number of tickets
    event.update(seats_left: event.seats_left + @ticket.number_of_tickets)

    @ticket.destroy!
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed. Seats have been updated." }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def ticket_params
    params.require(:ticket).permit(:user_id, :event_id, :room_id, :confirmation_number, :number_of_tickets, :total_price, :purchased_for_user_id)
  end
end
