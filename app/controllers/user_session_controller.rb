class UserSessionController < ApplicationController

  def create
    @user = User.find_by(username: params[:username])
    if @user
      if @user.authenticate(params[:password])
        session[:username] = @user.username
        render json: @user
      else
        render json: {error: "Incorrect Password"}, status: :unprocessable_entity
      end
    else
      render json: {error: "User Not Found"}, status: :unprocessable_entity
    end
  end

  def destroy
    session[:username] = nil
  end

end
