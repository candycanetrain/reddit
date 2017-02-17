class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #TODO -authenticity token

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
  end
end
