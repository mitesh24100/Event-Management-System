# Controls review actions including filtering reviews based on user role and review parameters
class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  # Lists reviews filtered by user name or email, and event name, with admin users having additional filtering capabilities
  def index

    if current_user.admin?
      @user_name = params[:user_name]
    else
      @email = params[:email]
    end

    @event_name = params[:event_name]

    if current_user.admin?
      if @user_name.present? && @event_name.present?
        @reviews = Review.includes(:user).where(user: { name: @user_name }).includes(:event).where(event: { name: @event_name })
      elsif @user_name.present?
        @reviews = Review.includes(:user).where(user: { name: @user_name })
      elsif @event_name.present?
        @reviews = Review.includes(:event).where(event: { name: @event_name })
      else
        @reviews = Review.all
      end
    else
      if @email.present? && @event_name.present?
        @reviews = Review.includes(:user).where(user: { email: @email }).includes(:event).where(event: { name: @event_name })
      elsif @email.present?
        @reviews = Review.includes(:user).where(user: { email: @email })
      elsif @event_name.present?
        @reviews = Review.includes(:event).where(event: { name: @event_name })
      else
        @reviews = Review.all
      end
    end
  end

  # GET /reviews/1 or /reviews/1.json
  # Displays details of a specific review
  def show
  end

  # GET /reviews/new
  # Initializes a new review instance and ensures the related event exists, or redirects if not found
  def new
    @review = Review.new
    begin
      @event = Event.find(params[:event_id])
      #@ticket = @event.tickets.build
    rescue ActiveRecord::RecordNotFound
      redirect_to events_path, alert: "Event not found."
    end
  end

  # GET /reviews/1/edit
  def edit

  end

  # POST /reviews or /reviews.json
  # Saves a new review to the database and handles success or failure responses
  def create

    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  # Updates a review's details in the database and handles success or failure responses, including custom validation scenarios
  def update

    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        #@event=Event.find(@review.event_id)
        #@reviewer=current_user.id
        #@review.errors.add(:user_id , "User not attended Event or Cannot Add review for someone else" )
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  # Deletes a review and confirms the successful deletion to the user.
  def destroy
    @review.destroy!

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Finds and sets a review based on the review id for actions that require an id.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:event_id,:user_id,:feedback, :rating)
    end
end
