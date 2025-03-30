class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    authorize [:user_dashboard, :dashboard], :index?
  end
end