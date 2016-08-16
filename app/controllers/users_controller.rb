class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:update, :destroy]

  def create
    @user = User.new(user_params)
    if @user.save
      session[:username] = @user.username
      render json: @user, serializer: UserSerializer
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      session[:username] = @user.username
      render json: @user, serializer: UserSerializer
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    @user.destroy
  end

  def show
    @user = User.find_by(username: params[:username])
    render json: @user, serializer: UserSerializer
  end

  private

  def user_params
    params.permit(:username, :email, :password, :starting_weight, :feet, :inches)
  end

end
