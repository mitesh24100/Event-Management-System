# Base controller setting up authentication system across the application.
class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authorized
  helper_method :logged_in?

  # Returns the current logged-in user based on the session's user_id.
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  # Checks if there is a user logged in by verifying the presence of current_user
  def logged_in?
    !current_user.nil?
  end

  # Redirects to the root path unless the user is logged in, enforcing authentication
  def authorized
    redirect_to root_path unless logged_in?
  end
end
