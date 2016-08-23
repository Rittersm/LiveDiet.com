class PlansController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:create, :update, :destroy]
  before_filter :newplan, only: [:index, :show]
  before_filter :newlog, only: [:index, :show]
  before_filter :newcheckin, only: [:index, :show]
  before_filter :newsub, only: [:index, :show]
  before_filter :newuser, only: [:index, :show]

  def create
    @newplan = Plan.new(plan_params)
    if @newplan.save
      render json: @newplan, status: :created
    else
      render json: @newplan.errors, status: :unprocessable_entity
    end
  end

  def index
    @plans = Plan.all.order(rating: :desc)
    respond_to do |format|
      format.html
      format.json {render json: @plans, each_serializer: PlanSerializer}
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @subscription = @plan.subscriptions.all
    respond_to do |format|
      format.html
      format.json {render json: @plan, serializer: PlanSerializer}
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :overview, :category_id)
  end

end
