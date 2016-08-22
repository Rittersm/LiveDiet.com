class LogsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:create, :update, :destroy]

  def create
    @newlog = Log.new(log_params)
    @newlog.user = current_user
    @newlog.plan = current_user.current_plan
    if @newlog.save
      render json: @newlog, status: :created
    else
      render json: @newlog.errors, status: :unprocessable_entity
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

  def index
    if params[:id] == 'me'
      @log = current_user.logs
      render json: @sub, serializer: LogSerializer
    else
      @log = User.logs
      render json: @sub, serializer: LogSerializer
    end
  end

  private

  def log_params
    params.require(:log).permit(:daily_overview)
  end

end
