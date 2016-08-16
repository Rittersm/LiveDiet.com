class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:username]
      @current_user ||= User.find_by(username: session[:username])
    end
    @current_user
  end

  def require_user
    render json: {error: "You must be logged in"}, status: :forbidden unless current_user
  end

end
