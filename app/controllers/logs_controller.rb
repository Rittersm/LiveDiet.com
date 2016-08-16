class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:create, :update, :destroy]

  def create
    @log = current_user.logs.new(log_params)
    @log.plan = current_user.current
    if @log.save
      render json: @log, status: :created
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  def update
    @log = current_user.logs.find(params[:id])
    if @log.update(log_params)
      render json: @log
    else
      render json: @log.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @log = current_user.logs.find(params[:id])
    @log.destroy
  end

  private

  def log_params
    params.permit(:daily_overview)
  end

end
