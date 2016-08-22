class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session[:username]
      @current_user ||= User.find_by(username: session[:username])
    end
    @current_user
  end

  def require_user
    render json: {error: "You must be logged in"}, status: :forbidden unless current_user
  end

  def newuser
    @newuser = User.new
  end

  def newplan
    @newplan = Plan.new
  end

  def newlog
    if current_user
      @newlog = Log.new
      @newlog.user = current_user
      @newlog.plan = current_user.current_plan
    else
      @newlog = Log.new
    end
  end

  def newcheckin
    if current_user
      @newcheckin = CheckIn.new
      @newcheckin.user = current_user
      @newcheckin.subscription = current_user.subscriptions.last
    else
      @newcheckin = CheckIn.new
    end
  end

  def newsub
    if current_user
      @newsub = current_user.subscriptions.new
    else
      @newsub = Subscription.new
    end
  end

end
