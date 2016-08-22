class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:update, :destroy]
  before_filter :newplan, only: [:index, :show]
  before_filter :newlog, only: [:index, :show]
  before_filter :newcheckin, only: [:index, :show]
  before_filter :newsub, only: [:index, :show]
  before_filter :newuser, only: [:index, :show]

  def create
    @newuser = User.new(user_params)
    if @newuser.save
      session[:username] = @newuser.username
      render json: @newuser, serializer: UserSerializer
    else
      render json: @newuser.errors, status: :unprocessable_entity
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

  def index
    @user = User.all
    render json: @user, serializer: UserSerializer
  end

  def show
    @user = User.find(params[:id])
    @checkins = @user.check_ins.all
    @logs = @user.logs.all
    respond_to do |format|
      format.html
      format.json {render json: @user, serializer: UserSerializer}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :starting_weight, :feet, :inches)
  end

end
