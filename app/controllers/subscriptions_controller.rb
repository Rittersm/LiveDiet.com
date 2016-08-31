class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:create, :update, :destroy]

  def create
    @plan = Plan.find(params[:plan_id])
    @newsub = current_user.subscriptions.new(subscription_params)
    @newsub.plan = @plan
    if @newsub.save
      render json: @newsub, status: :created
    else
      render json: @newsub.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @rating = Rating.find_by(value: params[:value])
    @sub = current_user.current_subscription
    @sub.rating = @rating
    if @sub.save
      render json: @sub, status: :accepted
    else
      render json: @sub.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @sub = current_user.subscriptions.find(params[:id])
    @sub.destroy
    redirect_to root_path
  end

  def show
    @sub = Subscription.find(params[:id])
    render json: @sub, serializer: SubscriptionSerializer
  end

  def index
    if params[:id] == 'me'
      @sub = current_user.subscriptions
      render json: @sub, serializer: SubscriptionSerializer
    else
      @sub = User.subscriptions
      render json: @sub, serializer: SubscriptionSerializer
    end
  end

  def weight_chart
    subscription = Subscription.find(params[:id])
    render json: subscription.user.check_ins.unscoped.group_by_week(:created_at).sum(:weight)
  end

  def bmi_chart
    subscription = Subscription.find(params[:id])
    render json: subscription.user.check_ins.unscoped.group_by_week(:created_at).sum(:new_bmi)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:expectations, :rating)
  end

end
