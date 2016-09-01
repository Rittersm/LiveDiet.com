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
      render json: @newplan.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    @loss_plans = Plan.categorized_plans("Weight Loss").page(params[:page]).per(4)
    @gain_plans = Plan.categorized_plans("Weight Gain").page(params[:page]).per(4)
    @mass_plans = Plan.categorized_plans("Muscle Mass").page(params[:page]).per(4)
    if params[:category] == "Weight Loss"
      @plans = Plan.categorized_plans("Weight Loss").page(params[:page]).per(4)
    elsif
      @plans = Plan.categorized_plans("Weight Gain").page(params[:page]).per(4)
    elsif
      @plans = Plan.categorized_plans("Muscle Mass").page(params[:page]).per(4)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @subscription = @plan.subscriptions.all.page(params[:page]).per(4)
    respond_to do |format|
      format.html
      format.js
      format.json {render json: @plan, serializer: PlanSerializer}
    end
  end

  def weight_chart
    plan = Plan.find(params[:id])
    render json: plan.avg_change(:weight_difference)
  end

  def bmi_chart
    plan = Plan.find(params[:id])
    render json: plan.avg_change(:bmi_difference)
  end

  private

  def plan_params
    params.require(:plan).permit(:title, :overview, :category_id)
  end

end
