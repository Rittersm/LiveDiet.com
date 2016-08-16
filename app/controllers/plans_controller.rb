class PlansController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:create, :update, :destroy]

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      render json: @plan, status: :created
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  def index
    @plans = Plan.all
    render json: @plans, serializer: PlanSerializer
  end

  def show
    @plan = Plan.find(params[:id])
    render json: @plan, serializer: CompletePlanSerializer
  end

  private

  def plan_params
    params.permit(:title, :overview, :category)
  end

end
