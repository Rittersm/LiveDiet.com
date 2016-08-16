class UserSessionController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:destroy]

  def create
    @user = User.find_by(username: params[:username])
    if @user
      if @user.authenticate(params[:password])
        session[:username] = @user.username
        render json: @user, serializer: UserSerializer
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
