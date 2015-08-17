class Api::UsersController < ApplicationController

  wrap_parameters false

  def show
    @user = User.find(params[:id])
    # render :show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # sign_in!(@user)
      # render :show
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :city, :state, :bio)
  end
end
