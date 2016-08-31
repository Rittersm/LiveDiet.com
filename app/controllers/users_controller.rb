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
      UserMailer.signup_email(@newuser).deliver
      session[:username] = @newuser.username
      render json: @newuser, status: :created
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
    @logs = @user.logs.all.page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
      format.json {render json: @user, serializer: UserSerializer}
    end
  end

  def weight_chart
    user = User.find(params[:id])
    render json: user.check_ins.unscoped.group_by_week(:created_at).sum(:weight)
  end

  def bmi_chart
    user = User.find(params[:id])
    render json: user.check_ins.unscoped.group_by_week(:created_at).sum(:new_bmi)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :starting_weight, :feet, :inches, :profile_image)
  end

end
