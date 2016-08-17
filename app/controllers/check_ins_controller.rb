class CheckInsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:create, :update, :destroy]

  def create
    @checkin = current_user.check_ins.new(checkin_params)
    @checkin.plan = current_user.current_plan
    if @checkin.save
      render json: @checkin, status: :created
    else
      render json: @checkin.errors, status: :unprocessable_entity
    end
  end

  def update
    @checkin = current_user.check_ins.find(params[:id])
    if @checkin.update(checkin_params)
      render json: @checkin
    else
      render json: @checkin.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @checkin = current_user.check_ins.find(params[:id])
    @checkin.destroy
  end

  def index
    if params[:id] == 'me'
      @checkin = current_user.check_ins
      render json: @sub, serializer: CheckInSerializer
    else
      @checkin = User.check_ins
      render json: @sub, serializer: CheckInSerializer
    end
  end

  private

  def checkin_params
    params.permit(:weight)
  end

end
