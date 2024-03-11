# Manages user operations including creation, update, and deletion, with authorization exceptions for new users
class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  # Lists all users for admin users; redirects non-admins to the root URL
  def index
    @current_user = current_user
    if current_user.admin?
      @users = User.all
    else
      redirect_to root_url
    end
  end

  # GET /users/1 or /users/1.json
  # Displays details of a specific user; restricts access to the user themselves or an admin
  def show
    if current_user.admin?
      puts "user admin"
    elsif params[:id].to_i != current_user.id.to_i
      redirect_to root_url
    end
  end

  # GET /users/new
  # Initializes a new user instance for account creation
  def new
    @user = User.new
  end

  # GET /users/1/edit
  # Prepares a user for editing; restricts access unless it's the user themselves or an admin
  def edit
    if params[:id].to_i != current_user.id.to_i && !current_user.admin?
      redirect_to root_url
    end
  end

  # POST /users or /users.json
  # Processes the creation of a new user account and handles responses based on the operation's success or failure
  def create
    @user = User.new(new_user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  # Updates an existing user's details and handles responses based on the operation's success or failure
  def update
    respond_to do |format|
      if @user.update(edit_user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1 or /users/1.json
  # Deletes a user account; prevents deletion of admin accounts and clears session unless performed by an admin
  def destroy
    if @user.admin?
      respond_to do |format|
        format.html { redirect_to root_url, notice: "Cannot delete Admin User" }
        format.json { head :no_content }
      end
      return
    end
    session[:user_id] = nil unless current_user.admin?
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def edit_user_params
    params.require(:user).permit(:password, :password_confirmation, :name, :email, :address, :credit_card_number, :phone_number)
  end

  def new_user_params
    params.require(:user).permit(:password, :password_confirmation, :name, :email, :address, :credit_card_number, :phone_number)
  end
end
