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
      render json: @newsub.errors, status: :unprocessable_entity
    end
  end

  def update
    @sub = current_user.subscriptions.find(params[:id])
    @sub.update(subscription_params)
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
    render json: subscription.user.check_ins.group_by_week(:created_at).sum(:weight)
  end

  def bmi_chart
    subscription = Subscription.find(params[:id])
    render json: subscription.user.check_ins.group_by_week(:created_at).sum(:new_bmi)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:expectations, :rating)
  end

end
