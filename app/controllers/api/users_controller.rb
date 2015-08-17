class Api::UsersController < ApplicationController

  wrap_parameters false

  def show
    @user = User.find(params[:id])
    # render :show
    render :show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # sign_in!(@user)
      # render :show
      render :show
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit

  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :city, :state, :bio)
  end
end
