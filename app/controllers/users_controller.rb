class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:username] = @user.username
      render json: 
    else

  end

  def update
    @user = current_user
    if @user.update(user_params)

    else

    end
  end

  def destroy
    @user = current_user
    @user.destroy
  end

  def show
    @users = User.find_by(username: params[:username])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :starting_weight, :feet, :inches)
  end

end
