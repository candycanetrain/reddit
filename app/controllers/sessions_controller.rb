class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(params[:username], params[:password])
    if user
      log_in(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def new
    render :new
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
