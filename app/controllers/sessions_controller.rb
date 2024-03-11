# Handles user sessions, including login and logout processes, with exceptions for authorization.
class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  def new
  end

  # Authenticates user credentials and initiates a session or redirects with an error on failure
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      # render "new"
      flash[:alert] = "Email or password is invalid"
      redirect_to login_url
    end
  end

  # Logs out the current user by clearing the session and redirects to the root URL.
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
