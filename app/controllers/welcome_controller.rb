class WelcomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_user, only: [:create, :update, :destroy]
  before_filter :newplan, only: [:index, :show]
  before_filter :newlog, only: [:index, :show]
  before_filter :newcheckin, only: [:index, :show]
  before_filter :newsub, only: [:index, :show]
  before_filter :newuser, only: [:index, :show]

  def show
    @disable_sidebar = true
  end

end
