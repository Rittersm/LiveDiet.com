class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:create, :destroy]

  def create
    @sub = current_user.subscriptions.new(subscription_params)
    if @sub.save
      render json: @sub, status: :created
    else
      render json: @sub.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @sub = current_user.subscriptions.find(params[:id])
    @sub.destroy
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

  private

  def subscription_params
    params.permit(:expectations, :rating, :plan_id)
  end

end
