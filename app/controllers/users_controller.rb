class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_url(@user)
    else
      # render text: user.errors.full_messages
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def new
    render :new
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def destroy
    log_out!(current_user)
    redirect_to new_user_url(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
