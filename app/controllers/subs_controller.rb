class SubsController < ApplicationController
  before_action :require_signed_in!, except: [:index, :show]
  before_action :require_user_own_sub, only: [:edit, :update]

  def create
    redirect_to new_session_url unless logged_in?
    @sub = Sub.new(title: sub_params[:title], description: sub_params[:description], moderator_id: current_user.id)
    if @sub.save
      render :show
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    render :new
  end

  def index
  end

  def show
    render :show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def require_user_own_sub
    sub = Sub.find_by(id: params[:sub][:id])
    unless sub.moderator_id == current_user.id
      redirect_to new_session_url unless logged_in?
    end
  end
end
