class UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if user.save
      log_in(user)
      redirect_to user_url
    else
      # render text: user.errors.full_messages
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def new
    render :new
  end

  def show
    render :show
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
